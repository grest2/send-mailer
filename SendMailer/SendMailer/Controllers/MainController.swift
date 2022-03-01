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
    
    private let manager: ISMTPManager = Resolver.resolve()
    private let cache: ICacheManager = Resolver.resolve()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIUtilities.applyTap(action: #selector(sendMail), initer: self, target: self.sendButton)
        UIUtilities.applyTap(action: #selector(showSettins), initer: self, target: self.settingsButton)
    }
    
    @objc private func sendMail() {
        let user = Mail.User(name: "test", email: self.addres.text ?? "")
        let sender = Mail.User(name: "Ilya", email: self.cache.getValue(forKey: .email))
        
        let mail = Mail(from: sender, to: [user],text: self.messageBody.text)
        self.manager.sendMessage(mail: mail)
            .then({
                print("_LOG_ done")
            }).catch({
                _ in
                print("_LOG_ failure")
            })
    }

    @objc private func showSettins() {
        self.performSegue(withIdentifier: "showSettings", sender: self)
    }
}

