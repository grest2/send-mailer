//
//  ICacheManager.swift
//  SendMailer
//
//  Created by iOS Developer on 3/1/22.
//

import Foundation

enum CacheKeys: String {
    case host
    case port
    case email
    case password
}

protocol ICacheManager {
    
    func saveValue(forKey: CacheKeys, value: String)
    func getValue(forKey: CacheKeys) -> String
    
    func setSecureValue(forKey: CacheKeys, value: String)
    func getSecureValue(forKey: CacheKeys, value: String) -> String
}
