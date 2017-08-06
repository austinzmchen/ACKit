//
//  ACLog.swift
//  <?>App
//
//  Created by Austin Chen on 2017-06-19.
//  Copyright © 2016 10.1. All rights reserved.
//

import Foundation

// MARK: global func
public func acLog(error msg: String = "",
         function: String = #function,
         file: String = #file,
         line: Int = #line)
{
    acLog(msg: msg, logLevel: .error)
}

public func acLog(info msg: String = "",
           function: String = #function,
           file: String = #file,
           line: Int = #line)
{
    acLog(msg: msg, logLevel: .info)
}

public func acLog(debug msg: String = "",
           function: String = #function,
           file: String = #file,
           line: Int = #line)
{
    acLog(msg: msg, logLevel: .debug)
}

public func acLog(msg: String = "",
         logLevel: ACLogLevel,
         function: String = #function,
         file: String = #file,
         line: Int = #line)
{
    let f = file.components(separatedBy: "/").last ?? ""
    let msg = "\"\(msg)\" - (File: \(f), Function: \(function), Line: \(line))"
    ACLog.shared.log(msg: msg, level: logLevel)
}

// MARK: class 

open class ACLog: NSObject {
    public static let shared = ACLog()
    
    open var logLevel: ACLogLevel = .info
    
    public override init() {
        super.init()
    }
    
    open func log(msg: String, level: ACLogLevel) {
        if logLevel.rawValue >= level.rawValue {
            print("ACLog: \(level.name) - \(msg)")
        }
    }
}

public enum ACLogLevel: Int {
    case none = 0
    case error
    case warning
    case info
    case debug
}

extension ACLogLevel {
    public var name: String {
        switch self {
        case .error:
            return "Error"
        case .warning:
            return "Warning"
        case .info:
            return "Info"
        case .debug:
            return "Debug"
        default:
            return "None"
        }
    }
}
