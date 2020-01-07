//
//  RSLog.swift
//  RSLog
//
//  Created by m3rk on 27/05/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation
import os

// MARK: - RSLogProtocol
public protocol RSLogProtocol {
    
    static var shared: Self { get }
    
    var isLogLevelTitleDisplayed: Bool { get set }
    var isLogLevelSymbolDisplayed: Bool { get set }
    var isFilenameDisplayed: Bool { get set }
    var isFunctionNameDisplayed: Bool { get set }
    @available(iOS 10.0, *)
    var isOSLogEnabled: Bool { get set }
    var logLevelTitleProvider: (_ level: LogLevel) -> String { get set }
    var logLevelSymbolProvider: (_ level: LogLevel) -> String { get set }
    
    func info(
        _ message: String,
        _ type: OSLog?,
        filename: String,
        function: String,
        line: UInt)
    
    func debug(
        _ message: String,
        _ type: OSLog?,
        filename: String,
        function: String,
        line: UInt)
    
    func error(
        _ message: String,
        _ type: OSLog?,
        filename: String,
        function: String,
        line: UInt)
}

// MARK: - LogLevel
public enum LogLevel {
    
    case info
    case debug
    case error
}

// MARK: - RSLog
final public class RSLog: RSLogProtocol {
    
    // MARK: - Public Properties
    public static let shared = RSLog()
    private init() {}
    public var isOSLogEnabled = true
    public var isLogLevelTitleDisplayed = true
    public var isLogLevelSymbolDisplayed = true
    public var isFilenameDisplayed = true
    public var isFunctionNameDisplayed = true
    
    // MARK: - Private Properties
    private let logQueue = DispatchQueue(label: "com.m3rk.log")
    
    // MARK: - Config
    public var logLevelTitleProvider: (_ level: LogLevel) -> String = { level in
        
        switch level {
        case .info:
            return "INFO"
        case .debug:
            return "DEBUG"
        case .error:
            return "ERROR"
        }
    }
    
    public var logLevelSymbolProvider: (LogLevel) -> String = { level in
        
        switch level {
        case .info:
            return "💾"
        case .debug:
            return "📟"
        case .error:
            return "🚨"
        }
    }

    // MARK: - Logging
    public func info(
        _ message: String,
        _ type: OSLog? = nil,
        filename: String = #file,
        function: String = #function,
        line: UInt = #line) {
        
        log(level: .info,
            message: message,
            type: type,
            filename: filename,
            function: function,
            line: line)
    }
    
    public func debug(
        _ message: String,
        _ type: OSLog? = nil,
        filename: String = #file,
        function: String = #function,
        line: UInt = #line) {
        
        log(level: .debug,
            message: message,
            type: type,
            filename: filename,
            function: function,
            line: line)
    }
    
    public func error(
        _ message: String,
        _ type: OSLog? = nil,
        filename: String = #file,
        function: String = #function,
        line: UInt = #line) {
        
        log(level: .error,
            message: message,
            type: type,
            filename: filename,
            function: function,
            line: line)
    }
    
    // MARK: - Util
    private func log(
        level: LogLevel,
        message: String,
        type: OSLog?,
        filename: String,
        function: String,
        line: UInt) {
        
        #if DEBUG
        logQueue.async { [weak self] in
            guard let `self` = self else { return }
            
            let logString = [
                self.formattedLogLevelString(from: level),
                self.formattedFilespecsStringFrom(
                    filename: filename,
                    function: function,
                    line: line),
                self.formattedMessageString(from: message)
                ]
                .compactMap { $0 }
                .joined(separator: " ")
            
            if self.isOSLogEnabled, #available(iOS 10.0, *) {
                if let logType = type {
                    os_log(
                        "%@",
                        log: logType,
                        type: self.getOSLogLevel(from: level),
                        logString)
                } else {
                    os_log(
                        "%@",
                        type: self.getOSLogLevel(from: level),
                        logString)
                }
            } else {
                print(logString)
            }
        }
        #endif
    }
    
    private func formattedLogLevelString(from logLevel: LogLevel) -> String? {
        
        guard isLogLevelTitleDisplayed || isLogLevelSymbolDisplayed else {
            return nil
        }
        let result = [
            isLogLevelSymbolDisplayed
                ? logLevelSymbolProvider(logLevel)
                : nil,
            isLogLevelTitleDisplayed
                ? logLevelTitleProvider(logLevel)
                : nil]
            .compactMap { $0 }
            .joined(separator: " ")
        return "[\(result)]"
    }
    
    private func formattedFilespecsStringFrom(
        filename: String,
        function: String,
        line: UInt) -> String? {
        
        guard isFilenameDisplayed || isFunctionNameDisplayed else {
            return nil
        }
        let result = [
            isFilenameDisplayed
                ? "\(formattedFilenameString(from: filename)): \(line)"
                : nil,
            isFunctionNameDisplayed
                ? function
                : nil]
            .compactMap { $0 }
            .joined(separator: " ")
        return "[\(result)]"
    }
    
    private func formattedMessageString(from logMessage: String) -> String {

        let startHint = "\u{2b91}"
        return "\n    \(startHint) \(logMessage)"
    }
    
    private func formattedFilenameString(from filename: String) -> String {
        
        return filename.components(separatedBy: "/").last?
            .components(separatedBy: ".").first ?? "???"
    }
    
    @available(iOS 10.0, *)
    private func getOSLogLevel(from logLevel: LogLevel) -> OSLogType {
        
        switch logLevel {
        case .info:
            return .default
        case .debug:
            return .debug
        case .error:
            return .error
        }
    }
}

// MARK: - OSLog Usage Tips
//extension OSLog {
//    private static var subsystem = Bundle.main.bundleIdentifier!
//
//    static let ui = OSLog(subsystem: subsystem, category: "UI")
//    static let network = OSLog(subsystem: subsystem, category: "Network")
//}
//RSLog.shared.info("test", .network)

