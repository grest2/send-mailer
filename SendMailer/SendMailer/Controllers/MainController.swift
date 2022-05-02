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
            let privateKey = Curve25519.Signing.PrivateKey()
            let publicKeyData = privateKey.publicKey.rawRepresentation
            
            let signature = try! privateKey.signature(for: data)
            
            
            let att = Attachment(data: publicKeyData, mime: MimeType.key.rawValue, name: "Public key")
            let signed = Attachment(data: signature, mime: MimeType.bin.rawValue, name: "Signatured data")
            let mail = Mail(from: sender, to: [user] ,text: "message", attachments: [att, signed])
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
                
                let key = message.attachments.first(where: { $0.mimeType == MimeType.key.rawValue })!.data!
                let pubKey = try! Curve25519.Signing.PublicKey(rawRepresentation: key)
                let signature = message.attachments.first(where: { $0.mimeType == MimeType.bin.rawValue })!.data!
                
                let url = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
                let full = url.appendingPathComponent(self.fileName)
                
                if let data = try? Data(contentsOf: full), pubKey.isValidSignature(signature, for: data) {
                    print("_LOG_ valid")
                }
            }
    }
    
    @objc private func showSettins() {
        self.performSegue(withIdentifier: "showSettings", sender: self)
    }
}
