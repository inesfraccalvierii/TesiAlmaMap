//
//  SensorValueEntity.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 10/11/23.
//

import Foundation

import CoreData

extension SensorValueEntity {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<SensorValueEntity>{
        let request = NSFetchRequest<SensorValueEntity>(entityName: "SensorValueEntity")
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        return request
    }
    
    func convertToUser() -> SensorValue {
        SensorValue(id: Int32(self.id), idSensor:  Int32(self.idSensor), value:  Int32(self.value))
    }
    
}
