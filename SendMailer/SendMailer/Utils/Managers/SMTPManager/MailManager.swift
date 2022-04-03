//
//  SMTPManager.swift
//  SendMailer
//
//  Created by iOS Developer on 3/1/22.
//

import Foundation
import SwiftSMTP
import Promises
import Resolver

class MailManager: IMailManager {
    
    private let logger: ILogger = Resolver.resolve()
    private let cache: ICacheManager = Resolver.resolve()
    
    private lazy var smtp: SMTP = {
        let host = self.cache.getValue(forKey: .host)
        let port = self.cache.getValue(forKey: .port)
        let email = self.cache.getValue(forKey: .email)
        let password = self.cache.getValue(forKey: .password)
        
        let _smtp = SMTP(hostname: host, email: email, password: password, port: Int32(port) ?? 587, authMethods: [.login])
        return _smtp
    }()
    
    private var session: MCOIMAPSession {
        let session: MCOIMAPSession = MCOIMAPSession()
        
        session.hostname = self.cache.getValue(forKey: .host)
        session.port = UInt32(self.cache.getValue(forKey: .port)) ?? 1
        session.username = self.cache.getValue(forKey: .email)
        session.password = self.cache.getSecureValue(forKey: .password)
        session.connectionType = .TLS
        
        return session
    }
    
    func sendMessage(mail: Mail) -> Promise<Void> {
        return Promise(on: .global(qos: .background), {
            fulfill, reject in
            
            self.smtp.send(mail) {
                error in
                if let error = error {
                    self.logger.error("ERROR: error when mail send, description: \(error)")
                    
                    reject(error)
                }
            }
            fulfill(())
        })
    }
    
    func fetchMessages() -> Promise<MessageViewModel> {
        let uids = MCOIndexSet(range: MCORange(location: 1, length: UInt64.max))
        
        return Promise(on: .global(qos: .background), {
            fulfill, reject in
            if let fetching = self.session.fetchMessagesOperation(withFolder: MailFolderType.inbox.rawValue, requestKind: .headers, uids: uids) {
                fetching.start {
                    error, messages, vanished in
                    
                    if let error = error {
                        self.logger.warning("<MailManager>: error while fetching inbox messages, reason: \(error.localizedDescription)")
                        reject(error)
                    }
                    
                    if let messages: [MCOIMAPMessage] = messages as? [MCOIMAPMessage] {
                        if let messageFetch = self.session.fetchMessageOperation(withFolder: MailFolderType.inbox.rawValue, uid: messages.last?.uid ?? 1) {
                            messageFetch.start({
                                error, data in
                                
                                if let error = error {
                                    self.logger.warning("<MailManager>: error while fetching inbox message, reason: \(error.localizedDescription)")
                                    reject(error)
                                }
                                if let data = data {
                                    let parser: MCOMessageParser = MCOMessageParser(data: data)
                                    
                                    let attachments = parser.attachments() as? [MCOAttachment]
                                    let messageBody = parser.plainTextRendering()
                                    
                                    fulfill(MessageView(body: messageBody ?? "", attachments: attachments ?? []))
                                }
                            })
                        }
                    } else {
                        reject(CustomError().create(message: "Fetched messages is nil"))
                    }
                }
            }
        })
    }
    
    func checkConnection() -> Promise<Void> {
        return Promise(on: .global(qos: .background), {
            fulfill, reject in
            
            if let check = self.session.checkAccountOperation() {
                check.start({
                   error in
                    
                    if let error = error {
                        self.logger.warning(error.localizedDescription)
                        reject(error)
                    }
                    fulfill(())
                })
            }
            fulfill(())
        })
    }
}
