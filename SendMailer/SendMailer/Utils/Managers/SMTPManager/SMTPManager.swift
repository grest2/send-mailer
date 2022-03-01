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
    private let smtp: SMTP = {
        let _smtp = SMTP(hostname: "", email: "", password: "")
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
