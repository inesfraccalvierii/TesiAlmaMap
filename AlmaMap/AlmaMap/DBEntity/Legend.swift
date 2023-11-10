//
//  Legend.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 05/05/23.
//

import Foundation
import CoreLocation

struct Legend : Identifiable, Decodable {
    
    var id: Int32
    var code: String
    var name: String
    var nameEng: String
    
    init(id: Int32, code: String, name: String, nameEng: String) {
        self.id = id
        self.code = code
        self.name = name
        self.nameEng = nameEng
    }
}
