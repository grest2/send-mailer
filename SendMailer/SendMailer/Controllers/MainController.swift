//
//  ViewController.swift
//  SendMailer
//
//  Created by iOS Developer on 3/1/22.
//

import UIKit
import Resolver
import SwiftSMTP

class MainController: UIViewController {
    @IBOutlet weak var settingsButton: UIImageView!
    @IBOutlet weak var messageBody: UITextView!
    @IBOutlet weak var addres: UITextField!
    @IBOutlet weak var sendButton: BorderedView!
    
    private let manager: IMailManager = Resolver.resolve()
    private let cache: ICacheManager = Resolver.resolve()
    private let logger: ILogger = Resolver.resolve()
    private let crypto: ICryptoManager = Resolver.resolve()
    
    private let fileName: String = "test.docx"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIUtilities.applyTap(action: #selector(sendMail), initer: self, target: self.sendButton)
        UIUtilities.applyTap(action: #selector(showSettins), initer: self, target: self.settingsButton)
        
        self.manager.fetchMessages()
            .then {
                message in
                
                print(message)
            }
    }
    
    @objc private func sendMail() {
        let user = Mail.User(name: "test", email: self.addres.text ?? "")
        let sender = Mail.User(name: "Ilya", email: self.cache.getValue(forKey: .email))
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        let full = url.appendingPathComponent(self.fileName)
         
        if let data = try? Data(contentsOf: full) {
            let att = Attachment(data: data, mime: "application/msword", name: "Test")
            let mail = Mail(from: sender, to: [user] ,text: self.messageBody.text, attachments: [att])
            self.manager.sendMessage(mail: mail)
                .then({
                    self.logger.info("<MainController>: The Base-64 encoded string file: \(data.md5.base64EncodedString())")
                }).catch({
                    self.logger.warning("<MainController>: sending mas was failure, reason: \($0.localizedDescription)")
                })
        }
    }

    @objc private func showSettins() {
        self.performSegue(withIdentifier: "showSettings", sender: self)
    }
}
