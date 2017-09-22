//
//  UrlRequestExtensions.swift
//  StartAppsKitJson
//
//  Created by Gabriel Lanata on 7/11/16.
//
//

import Foundation
import Jessie

public extension URLRequest {
    
    public mutating func setHttpBody(_ body: Json) throws {
        try setJsonBody(body)
    }
    
    public mutating func setHttpBody<T>(_ body: T) throws where T : Encodable {
        try setJsonBody(body)
    }
    
    public mutating func setJsonBody(_ body: Data) throws {
        let data = body
        self.setValue("application/json", forHTTPHeaderField: "Accept")
        self.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        self.httpMethod = "POST"
        self.httpBody = data
    }
    
//    public mutating func setJsonBody(_ body: Dictionary) throws {
//        let data = try body.data(using: .utf8, allowLossyConversion: false)
//        try setJsonBody(data)
//    }
    
    public mutating func setJsonBody(_ body: String) throws {
        let data = body.data(using: .utf8, allowLossyConversion: false)!
        try setJsonBody(data)
    }
    
    public mutating func setJsonBody(_ body: Json) throws {
        let data = try body.data()
        try setJsonBody(data)
    }
    
    public mutating func setJsonBody<T>(_ body: T) throws where T : Encodable {
        let data = try JSONEncoder().encode(body)
        try setJsonBody(data)
    }
    
}
