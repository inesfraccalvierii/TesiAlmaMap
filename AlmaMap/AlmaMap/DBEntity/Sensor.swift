//
//  Sensor.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 26/10/23.
//

import Foundation
import CoreLocation

struct Sensor : Identifiable, Decodable {
    
    var id: Int32
    var code: String
    var typeCode: String
    var spaceId: Int32
    var systemId: Int32
    var viewId: Int32
    var objectId: Int32
    
    init(id: Int32, code: String, typeCode: String, spaceId: Int32, systemId: Int32, viewId: Int32, objectId: Int32) {
        self.id = id
        self.code = code
        self.typeCode = typeCode
        self.spaceId = spaceId
        self.systemId = systemId
        self.viewId = viewId
        self.objectId = objectId
        
    }
}

