//
//  Modeldata.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 05/05/23.
//

import Foundation

struct Modeldata<DataType> where DataType: Decodable {
    var list:  [DataType]
    
    init(fileName: String) {
        list = [DataType]()
        
        guard let file = Bundle.main.url(forResource: fileName, withExtension: nil)
        else { fatalError("File \(fileName) not found")}
        let data: Data
        
        do {
            data = try Data(contentsOf: file)
        } catch {
          fatalError("\(fileName) not loaded: \(error)")
        }
        
        let decoder = JSONDecoder()
        
        
        do {
            list = try decoder.decode([DataType].self, from: data)
            
        } catch {
            fatalError("Error parsing \(fileName) as \([DataType].self): \(error)")
        }
        
    }
    
    
}
