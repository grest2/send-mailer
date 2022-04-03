//
//  SettingsController.swift
//  SendMailer
//
//  Created by iOS Developer on 3/1/22.
//

import Foundation
import UIKit
import Resolver

class SettingsController: UIViewController {
    @IBOutlet weak var back: UIImageView!
    
    @IBOutlet weak var hostName: UITextField!
    @IBOutlet weak var port: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var connectionButton: UIButton!
    
    private let cacheManager: ICacheManager = Resolver.resolve()
    private let mailManager: IMailManager = Resolver.resolve()
    
    private let connectionTitle: String = "Test connection"
    
    override func viewDidLoad() {
        UIUtilities.applyTap(action: #selector(self.cancel), initer: self, target: self.back)

        self.infoSet()
    }
    
    @IBAction func testConnection(_ sender: Any) {
        self.mailManager.checkConnection()
            .then {
                _ in
                
                let action = UIAlertAction(title: "Ok", style: .default)
                UIUtilities.alertPresent(title: self.connectionTitle, message: "Connection was successuly", action: action, controller: self)
            }.catch {
                error in
                
                let action = UIAlertAction(title: "Ok", style: .default)
                UIUtilities.alertPresent(title: self.connectionTitle, message: "Connection was failure, reason: \(error.localizedDescription)", action: action, controller: self)
            }
    }
    
    @IBAction func clearStore(_ sender: Any) {
        DispatchQueue.main.async {
            self.cacheManager.clear()
            self.infoSet()
        }
    }
    
    private func infoSet() {
        self.hostName.text = self.cacheManager.getValue(forKey: .host)
        self.port.text = self.cacheManager.getValue(forKey: .port)
        self.email.text = self.cacheManager.getValue(forKey: .email)
        self.password.text = self.cacheManager.getSecureValue(forKey: .password)
    }
    
    private func infoSave() {
        DispatchQueue.main.async {
            self.cacheManager.saveValue(forKey: .host, value: self.hostName.text ?? "")
            self.cacheManager.saveValue(forKey: .port, value: self.port.text ?? "")
            self.cacheManager.saveValue(forKey: .email, value: self.email.text ?? "")
            self.cacheManager.setSecureValue(forKey: .password, value: self.password.text ?? "")
        }
    }
   
    @objc private func cancel() {
        self.infoSave()
        self.dismiss(animated: true, completion: nil)
    }
}
