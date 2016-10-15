//
//  JsonProcess.swift
//  Pods
//
//  Created by Gabriel Lanata on 2/10/16.
//
//

import Foundation
import SwiftyJSON

public func JsonProcess(_ loadedValue: Data) throws -> JSON {
    let object: Any = try JSONSerialization.jsonObject(with: loadedValue, options: .allowFragments)
    return JSON(object)
}

