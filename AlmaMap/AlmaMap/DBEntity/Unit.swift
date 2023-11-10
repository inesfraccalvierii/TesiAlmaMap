//
//  Unit.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 09/11/23.
//

import Foundation
import CoreLocation

struct Unit : Identifiable, Decodable {
 
    var code: String
    var symbol: String
    var id: Int32
    
    init(id: Int32, code: String, symbol: String) {
        self.id = id
        self.code = code
        self.symbol = symbol
    }
}

