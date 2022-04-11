//
//  MailUtilites.swift
//  SendMailer
//
//  Created by iOS Developer on 4/3/22.
//

import Foundation

enum MimeType: String {
    case word = "application/msword"
    case jpg = "image/jpeg"
    case png = "image/png"
}

enum MailFolderType: String {
    case inbox = "INBOX"
    case outbox = "OUTBOX"
}

enum ConnectionResult {
    case success
    case failure
}
