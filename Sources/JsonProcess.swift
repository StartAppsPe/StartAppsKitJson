//
//  JsonProcess.swift
//  Pods
//
//  Created by Gabriel Lanata on 2/10/16.
//
//

import Foundation
import Jessie

enum JSONError: LocalizedError {
    case couldNotParseString, couldNotParseData
    public var localizedDescription: String {
        switch self {
        case .couldNotParseString: return "Could not parse string"
        case .couldNotParseData: return "Could not parse data"
        }
    }
}

public enum JsonInnerError: LocalizedError {
    case containsError(String)
    public var localizedDescription: String {
        switch self {
        case .containsError(let message): return message
        }
    }
}

public func JsonProcess<T>(_ loadedValue: Data) throws -> T where T : Decodable {
    return try JSONDecoder().decode(T.self, from: loadedValue)
}

public func JsonProcess<T>(_ loadedValue: [UInt8]) throws -> T where T : Decodable {
    return try JSONDecoder().decode(T.self, from: Data(bytes: loadedValue))
}

public func JsonProcess<T>(_ loadedValue: String) throws -> T where T : Decodable {
    guard let loadedValue = loadedValue.data(using: .utf8) else {
        throw JSONError.couldNotParseString
    }
    return try JSONDecoder().decode(T.self, from: loadedValue)
}

public func JsonProcess<T>(_ loadedValue: Data, _ type: T.Type) throws -> T where T : Decodable {
    return try JSONDecoder().decode(T.self, from: loadedValue)
}

public func JsonProcess<T>(_ loadedValue: [UInt8], _ type: T.Type) throws -> T where T : Decodable {
    return try JSONDecoder().decode(T.self, from: Data(bytes: loadedValue))
}

public func JsonProcess<T>(_ loadedValue: String, _ type: T.Type) throws -> T where T : Decodable {
    guard let loadedValue = loadedValue.data(using: .utf8) else {
        throw JSONError.couldNotParseString
    }
    return try JSONDecoder().decode(T.self, from: loadedValue)
}


// MARK: Dictionary extensions

public extension Dictionary {
    
    public func jsonData(prettify: Bool = false) throws -> Data {
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        return try JSONSerialization.data(withJSONObject: self, options: options)
    }
    
    public func jsonString(prettify: Bool = false) throws -> String {
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        let jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
        guard let result = String(data: jsonData, encoding: .utf8) else {
            throw JSONError.couldNotParseData
        }
        return result
    }
    
}



// MARK: Legacy support


public func JessieProcess(_ loadedValue: Data) throws -> Json {
    return try Json.parse(data: loadedValue)
}

public func JessieProcess(_ loadedValue: [UInt8]) throws -> Json {
    return try Json.parse(bytes: loadedValue)
}

public func JessieProcess(_ loadedValue: String) throws -> Json {
    return try Json.parse(string: loadedValue)
}

public func JessieProcessWithError(_ loadedValue: Data) throws -> Json {
    return try Json.parse(data: loadedValue).processError()
}

public func JessieProcessWithError(_ loadedValue: [UInt8]) throws -> Json {
    return try Json.parse(bytes: loadedValue).processError()
}

public func JessieProcessWithError(_ loadedValue: String) throws -> Json {
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

