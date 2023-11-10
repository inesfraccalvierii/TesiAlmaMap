//
//  Floor.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 08/05/23.
//


import Foundation
import CoreLocation

struct Floor : Identifiable, Decodable {
    
    var id: Int32
    var number: Int32
    var svg: String
    var buildingId: Int32
    
    init(id: Int32, number: Int32, svg: String, buildingId: Int32) {
        self.id = id
        self.number = number
        self.svg = svg
        self.buildingId = buildingId
    }
}
