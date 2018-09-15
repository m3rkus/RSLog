//
//  RSLog.swift
//  RSLog
//
//  Created by m3rk on 27/05/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation


// MARK: - Properties
final public class RSLog {
    
    // MARK: Public var
    public static let shared = RSLog()
    
    public var verboseMode = false
    
    public var showLogLevelTitle = false
    
    // MARK: Private var
    private init() {}
    private let logQueue = DispatchQueue(label: "com.m3rk.log")
    
    private enum LogLevel {
        case info
        case warning
        case error
        case fatalError
        
        var title: String {
            switch self {
            case .info:
                return "INFO"
            case .warning:
                return "WARNING"
            case .error:
                return "ERROR"
            case .fatalError:
                return "FATAL ERROR"
            }
        }
        
        var symbol: String {
            switch self {
            case .info:
                return "✅"
            case .warning:
                return "⚠️"
            case .error:
                return "⛔️"
            case .fatalError:
                return "💥"
            }
        }
    }
    
}

// MARK: - Public func
extension RSLog: Logger {
    
    public func info(_ message: String,
                     filename: String = #file,
                     function: String = #function,
                     line: UInt = #line) {
        log(level: .info,
            message: message,
            filename: filename,
            function: function,
            line: line)
    }
    
    public func warning(_ message: String,
                        filename: String = #file,
                        function: String = #function,
                        line: UInt = #line) {
        log(level: .warning,
            message: message,
            filename: filename,
            function: function,
            line: line)
    }
    
    public func error(_ message: String,
                      filename: String = #file,
                      function: String = #function,
                      line: UInt = #line) {
        log(level: .error,
            message: message,
            filename: filename,
            function: function,
            line: line)
    }
    
    public func fatalError(_ message: String,
                           filename: String = #file,
                           function: String = #function,
                           line: UInt = #line) {
        log(level: .fatalError,
            message: message,
            filename: filename,
            function: function,
            line: line)
    }
    
}

// MARK: - Private func
extension RSLog {
    
    private func log(level: LogLevel,
                     message: String,
                     filename: String,
                     function: String,
                     line: UInt) {
        #if DEBUG
        logQueue.async { [weak self] in
            guard let `self` = self else { return }
            
            var metaInfoString: String
            if self.showLogLevelTitle {
                metaInfoString = "[\(level.symbol) \(level.title)] [\(self.format(filename)):\(line)] \(function)"
            } else {
                metaInfoString = "\(level.symbol) [\(self.format(filename)):\(line)] \(function)"
            }
            
            var logString: String
            if self.verboseMode {
                logString = "\(metaInfoString)\n    ⮑ \(message)"
            } else {
                logString = "\(metaInfoString) - \(message)"
            }
            
            print(logString)
            
            if level == .fatalError {
                Swift.fatalError()
            }
        }
        #endif
    }
    
    private func format(_ filename: String) -> String {
        return filename.components(separatedBy: "/").last?
                       .components(separatedBy: ".").first ?? "???"
    }
    
}
