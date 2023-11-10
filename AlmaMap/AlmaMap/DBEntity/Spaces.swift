//
//  Spaces.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 23/10/23.
//

import Foundation
import CoreLocation

struct Spaces : Identifiable, Decodable {
    
    var id: Int32
    var code: String
    var name: String
    var descriptions: String
    var floorId: Int32
    var legendId: Int32
    
    init(id: Int32, code: String, name: String, descriptions: String, floorId: Int32, legendId: Int32) {
        self.id = id
        self.code = code
        self.name = name
        self.descriptions = descriptions
        self.floorId = floorId
        self.legendId = legendId
    }
}


