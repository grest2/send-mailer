//
//  CustomError.swift
//  SendMailer
//
//  Created by iOS Developer on 4/3/22.
//

import Foundation

class CustomError: Error {
    var message: String = "Default"
    
    func create(message: String) -> CustomError {
        let error = CustomError()
        error.message = message
        
        return error
    }
}
