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

class SMTPManager: ISMTPManager {
    
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
}
