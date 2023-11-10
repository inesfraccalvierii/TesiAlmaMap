//
//  SensorValue.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 10/11/23.
//

import Foundation
import CoreLocation

struct SensorValue : Identifiable, Decodable {
    
    var id: Int32
    var idSensor: Int32
    var value: Int32
    
    init(id: Int32, idSensor: Int32, value: Int32) {
        self.id = id
        self.idSensor = idSensor
        self.value = value
    }
}
