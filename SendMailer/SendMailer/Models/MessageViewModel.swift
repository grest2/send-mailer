//
//  MessageViewModel.swift
//  SendMailer
//
//  Created by iOS Developer on 4/3/22.
//

import Foundation

class MessageView {
    var body: String
    var attachments: [MCOAttachment] = []
    
    init(body: String, attachments: [MCOAttachment] = []) {
        self.body = body
        self.attachments = attachments
    }
}
