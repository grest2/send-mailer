//
//  CryptoManager.swift
//  SendMailer
//
//  Created by iOS Developer on 4/3/22.
//

import Foundation
import CryptoKit

class CryptoManager: ICryptoManager {
    private var key256 = SymmetricKey(size: .bits256)
    
    func encryptedDataCode(data: Data) -> (Data, String) {
        let sha512MAC = HMAC<SHA512>.authenticationCode(for: data, using: self.key256)
        
        return (Data(sha512MAC), String(describing: sha512MAC))
    }
}
