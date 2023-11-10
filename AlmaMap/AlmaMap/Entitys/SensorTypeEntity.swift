//
//  SensorTypeEntity.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 26/10/23.
//

import Foundation

import CoreData

extension SensorTypeEntity {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<SensorTypeEntity>{
        let request = NSFetchRequest<SensorTypeEntity>(entityName: "SensorTypeEntity")
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        return request
    }
    
    func convertToUser() -> SensorType {
        SensorType(id: Int32(self.id), code: self.code!, unitCode: self.unitCode!, priority: self.priority)
    }
    
}
