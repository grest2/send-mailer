//
//  CacheManager.swift
//  SendMailer
//
//  Created by iOS Developer on 3/1/22.
//

import Foundation
import SwiftKeychainWrapper

class CacheManager: ICacheManager {
    
    private let defaults: UserDefaults = UserDefaults.standard
    
    func saveValue(forKey: CacheKeys, value: String) {
        self.defaults.removeObject(forKey: forKey.rawValue)
        self.defaults.set(value, forKey: forKey.rawValue)
    }
    
    func getValue(forKey: CacheKeys) -> String {
        if let value = self.defaults.value(forKey: forKey.rawValue) as? String {
            return value
        }
        return "empty"
    }
    
    func setSecureValue(forKey: CacheKeys, value: String) {
        KeychainWrapper.standard.removeObject(forKey: forKey.rawValue)
        KeychainWrapper.standard.set(value, forKey: forKey.rawValue)
    }
    
    func getSecureValue(forKey: CacheKeys) -> String {
        return KeychainWrapper.standard.string(forKey: forKey.rawValue) ?? ""
    }
    
    func clear() {
        KeychainWrapper.standard.removeAllKeys()
        self.defaults.removeObject(forKey: CacheKeys.password.rawValue)
        self.defaults.removeObject(forKey: CacheKeys.host.rawValue)
        self.defaults.removeObject(forKey: CacheKeys.email.rawValue)
        self.defaults.removeObject(forKey: CacheKeys.port.rawValue)
    }
}
