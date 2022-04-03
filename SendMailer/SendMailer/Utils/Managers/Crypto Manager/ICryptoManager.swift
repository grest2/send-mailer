//
//  ICryptoManager.swift
//  SendMailer
//
//  Created by iOS Developer on 4/3/22.
//

import Foundation

protocol ICryptoManager {
    func encryptedDataCode(data: Data) -> (Data, String)
}
