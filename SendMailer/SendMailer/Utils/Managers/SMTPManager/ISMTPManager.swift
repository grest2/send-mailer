//
//  ISMTPManager.swift
//  SendMailer
//
//  Created by iOS Developer on 3/1/22.
//

import Foundation
import Promises
import SwiftSMTP

protocol ISMTPManager {
    func sendMessage(mail: Mail) -> Promise<Void>
}
