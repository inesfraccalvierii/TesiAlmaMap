//
//  SensorEntity.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 26/10/23.
//

import Foundation

import CoreData

extension SensorEntity {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<SensorEntity>{
        let request = NSFetchRequest<SensorEntity>(entityName: "SensorEntity")
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        return request
    }
    
    func convertToUser() -> Sensor {
        Sensor(id: Int32(self.id), code: self.code!, typeCode: self.typeCode!, spaceId:  Int32(self.spaceId), systemId:  Int32(self.systemId), viewId:  Int32(self.viewId), objectId:  Int32(self.objectId) )
    }
    
}
