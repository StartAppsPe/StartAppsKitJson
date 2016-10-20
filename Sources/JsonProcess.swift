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

