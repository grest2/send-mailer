//
//  ViewController.swift
//  SendMailer
//
//  Created by iOS Developer on 3/1/22.
//

import UIKit
import Resolver
import SwiftSMTP
import CryptoKit

class MainController: UIViewController {
    @IBOutlet weak var settingsButton: UIImageView!
    @IBOutlet weak var messageBody: UITextView!
    @IBOutlet weak var addres: UITextField!
    @IBOutlet weak var sendButton: BorderedView!
    
    private let manager: IMailManager = Resolver.resolve()
    private let cache: ICacheManager = Resolver.resolve()
    private let logger: ILogger = Resolver.resolve()
    private let crypto: ICryptoManager = Resolver.resolve()
    
    private let symmetricKey = SymmetricKey(size: .bits256)
    
    private let fileName: String = "test.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIUtilities.applyTap(action: #selector(sendMail), initer: self, target: self.sendButton)
        UIUtilities.applyTap(action: #selector(showSettins), initer: self, target: self.settingsButton)
        
    }
    
    @objc private func sendMail() {
        let user = Mail.User(name: "test", email: "polyanaozero@gmail.com" ?? "")
        let sender = Mail.User(name: "Ilya", email: self.cache.getValue(forKey: .email))
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        let full = url.appendingPathComponent(self.fileName)
        
        if let data = try? Data(contentsOf: full) {
            
            let sealedData = try! ChaChaPoly.seal(data, using: symmetricKey).combined
            let box = try! ChaChaPoly.SealedBox(combined: sealedData)
            let decr = try! ChaChaPoly.open(box, using: self.symmetricKey)
            
            let att = Attachment(data: sealedData, mime: MimeType.png.rawValue, name: "Test")
            let mail = Mail(from: sender, to: [user] ,text: String(describing: self.symmetricKey), attachments: [att])
            self.manager.sendMessage(mail: mail)
                .then({
                    self.logger.info("_LOG_: file was send with size: \(data.count)")
                }).catch({
                    self.logger.warning("<MainController>: sending mas was failure, reason: \($0.localizedDescription)")
                })
        }
    }
    @IBAction func fetch(_ sender: Any) {
        self.manager.fetchMessages()
            .then {
                message in
                if let file = message.attachments.first?.data {
                    let box = try! ChaChaPoly.SealedBox(combined: file)
                    let decrypt = try! ChaChaPoly.open(box, using: self.symmetricKey)
                    
                    print("_LOG_: Decrypted file size: \(decrypt.count)")
                }
                print(message)
            }
    }
    
    @objc private func showSettins() {
        self.performSegue(withIdentifier: "showSettings", sender: self)
    }
}
