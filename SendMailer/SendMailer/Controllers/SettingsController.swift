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
    
    private let cacheManager: ICacheManager = Resolver.resolve()
    
    override func viewDidLoad() {
        UIUtilities.applyTap(action: #selector(self.cancel), initer: self, target: self.back)

        self.infoSet()
    }
    
    private func infoSet() {
        self.hostName.text = self.cacheManager.getValue(forKey: .host)
        self.port.text = self.cacheManager.getValue(forKey: .port)
        self.email.text = self.cacheManager.getValue(forKey: .email)
        self.password.text = self.cacheManager.getValue(forKey: .password)
    }
    
    private func infoSave() {
        DispatchQueue.global(qos: .background).async {
            self.cacheManager.saveValue(forKey: .host, value: self.hostName.text ?? "")
            self.cacheManager.saveValue(forKey: .port, value: self.port.text ?? "")
            self.cacheManager.saveValue(forKey: .email, value: self.email.text ?? "")
            self.cacheManager.saveValue(forKey: .password, value: self.password.text ?? "")
        }
    }
   
    @objc private func cancel() {
        self.infoSave()
        self.dismiss(animated: true, completion: nil)
    }
}
