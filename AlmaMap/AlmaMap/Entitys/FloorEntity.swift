//
//  FloorEntity.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 08/05/23.
//


import Foundation

import CoreData

extension FloorEntity {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<FloorEntity>{
        let request = NSFetchRequest<FloorEntity>(entityName: "FloorEntity")
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        return request
    }
    
    func convertToUser() -> Floor {
        Floor(id: Int32(self.id), number: Int32(self.number), svg: self.svg!, buildingId: Int32(self.buildingId))
    }
    
}
