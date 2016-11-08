//
//  UrlRequestExtensions.swift
//  StartAppsKitJson
//
//  Created by Gabriel Lanata on 7/11/16.
//
//

import Foundation

public extension URLRequest {
    
    public mutating func setHttpBody(_ body: Json) throws {
        let data = try body.data()
        self.setValue("application/json", forHTTPHeaderField: "Accept")
        self.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        self.httpMethod = "POST"
        self.httpBody = data
    }
    
}
