//
//  Logger.swift
//  AudioYikYak
//
//  Created by Seun Adekunle on 11/27/23.
//

import Foundation

class Logger {
    static let shared = Logger()

    private init() {}

    func info(_ message: String) {
        log("INFO: \(message)")
    }

    func debug(_ message: String) {
        log("DEBUG: \(message)")
    }

    func warning(_ message: String) {
        log("WARNING: \(message)")
    }

    func error(_ message: String) {
        log("ERROR: \(message)")
    }

    private func log(_ message: String) {
        print(message)
    }
}
