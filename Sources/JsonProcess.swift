//
//  JsonProcess.swift
//  Pods
//
//  Created by Gabriel Lanata on 2/10/16.
//
//

import Foundation
import Jessie

public func JsonProcess(_ loadedValue: Data) throws -> Json {
    return try Json.parse(data: loadedValue)
}

public func JsonProcess(_ loadedValue: [UInt8]) throws -> Json {
    return try Json.parse(bytes: loadedValue)
}

public func JsonProcess(_ loadedValue: String) throws -> Json {
    return try Json.parse(string: loadedValue)
}

public func JsonProcessWithError(_ loadedValue: Data) throws -> Json {
    return try Json.parse(data: loadedValue).processError()
}

public func JsonProcessWithError(_ loadedValue: [UInt8]) throws -> Json {
    return try Json.parse(bytes: loadedValue).processError()
}

public func JsonProcessWithError(_ loadedValue: String) throws -> Json {
    return try Json.parse(string: loadedValue).processError()
}

public extension Json {
    
    @discardableResult
    func processError() throws -> Json {
        if let error = self["error"].bool, error == true {
            let message = self["message"].string ?? "Unknown Error"
            throw JsonInnerError.containsError(message)
        }
        if let error = self["error"].string {
            throw JsonInnerError.containsError(error)
        }
        if let error = self["error"]["message"].string {
            throw JsonInnerError.containsError(error)
        }
        return self
    }
    
}

public enum JsonInnerError: Error, CustomStringConvertible {
    case containsError(String)
    public var description: String {
        switch self {
        case .containsError(let message): return message
        }
    }
}
