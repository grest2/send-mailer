//
//  Logger.swift
//  SendMailer
//
//  Created by iOS Developer on 3/1/22.
//

import Foundation
import SwiftyBeaver

class Logger: ILogger {
    private static let instance: Logger = Logger()
    private let log = SwiftyBeaver.self

    private init() {}

    public func setup() {
        // Logging to console for development puproses
        let console = ConsoleDestination()
        console.format = "$L: $M"
        console.minLevel = .info;

        self.log.addDestination(console)

        self.log.info("Swifty Beaver has been successfully inited")
    }

    public func verbose(_ message: Any) {
        self.log.verbose(message)
    }

    public func verbose(_ message: Any, context: Any?) {
        self.log.verbose(message, context: context)
    }

    public func debug(_ message: Any) {
        self.log.debug(message)
    }

    public func debug(_ message: Any, context: Any?) {
        self.log.debug(message, context: context)
    }

    public func info(_ message: Any) {
        self.log.info(message)
    }

    public func info(_ message: Any, context: Any?) {
        self.log.info(message, context: context)
    }

    public func warning(_ message: Any) {
        self.log.warning(message)
    }

    public func warning(_ message: Any, context: Any?) {
        self.log.warning(message, context: context)
    }

    public func error(_ message: Any) {
        self.log.error(message)
    }

    public func error(_ message: Any, context: Any?) {
        self.log.error(message, context: context)
    }

    public static func getInstance() -> ILogger {
        return self.instance
    }
}
