//
//  MailUtilites.swift
//  SendMailer
//
//  Created by iOS Developer on 4/3/22.
//

import Foundation

enum MailFolderType: String {
    case inbox = "INBOX"
    case outbox = "OUTBOX"
}

enum ConnectionResult {
    case success
    case failure
}
