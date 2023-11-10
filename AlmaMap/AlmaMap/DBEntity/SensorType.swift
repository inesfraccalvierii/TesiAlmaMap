//
//  SensorType.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 26/10/23.
//

import Foundation
import CoreLocation

struct SensorType : Identifiable, Decodable {
    
    var id: Int32
    var code: String
    var unitCode: String
    var priority: Int32
    
    init(id: Int32, code: String, unitCode: String, priority: Int32) {
        self.id = id
        self.code = code
        self.unitCode = unitCode
        self.priority = priority
    }
}

