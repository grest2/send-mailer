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
        self.defaults.value(forKey: forKey.rawValue) as! String
    }
    
    func setSecureValue(forKey: CacheKeys, value: String) {
        KeychainWrapper.standard.removeObject(forKey: forKey.rawValue)
        KeychainWrapper.standard.set(value, forKey: forKey.rawValue)
    }
    
    func getSecureValue(forKey: CacheKeys, value: String) -> String {
        return KeychainWrapper.standard.string(forKey: forKey.rawValue) ?? ""
    }
}
