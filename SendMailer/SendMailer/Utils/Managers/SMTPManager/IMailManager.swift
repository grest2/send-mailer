//
//  ISMTPManager.swift
//  SendMailer
//
//  Created by iOS Developer on 3/1/22.
//

import Foundation
import Promises
import SwiftSMTP

protocol IMailManager {
    func sendMessage(mail: Mail) -> Promise<Void>
    
    //MARK: via IMAP
    func fetchMessages() -> Promise<MessageViewModel>
    func checkConnection() -> Promise<Void>
}
