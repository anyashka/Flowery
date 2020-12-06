//
//  Logger.swift
//  Flowery
//

import Foundation

/// Convenience log type.
enum LogKind: String {
    case info = "[INFO]"
    case warning = "[WARNING]"
    case error = "[ERROR]"
}

/// Universal logging function
///
/// - Parameter kind: defines log class: info, warning or error
/// - Parameter message: log message
func log(kind: LogKind = .info, message: String) {
    NSLog("\(kind.rawValue.uppercased()):Flowery:\(message)")
}

/// Simplified logging function - for info logs.
///
/// - Parameter message: log message.
func log(_ message: String) {
    log(kind: .info, message: message)
}

/// Simplified logging function - for warnings.
///
/// - Parameter message: log message.
func logWarning(_ message: String) {
    log(kind: .warning, message: message)
}

/// Simplified logging function - for errors.
///
/// - Parameter message: log message.
func logError(_ message: String) {
    log(kind: .error, message: message)
}
