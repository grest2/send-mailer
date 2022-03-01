//
//  ILogger.swift
//  SendMailer
//
//  Created by iOS Developer on 3/1/22.
//

import Foundation

protocol ILogger {
    func setup()

    func debug(_ message: Any)
    func debug(_ message: Any, context: Any?)
    func info(_ message: Any)
    func info(_ message: Any, context: Any?)
    func warning(_ message: Any)
    func warning(_ message: Any, context: Any?)
    func error(_ message: Any)
    func error(_ message: Any, context: Any?)
}
