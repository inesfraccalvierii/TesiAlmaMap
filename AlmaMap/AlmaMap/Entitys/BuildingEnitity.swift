//
//  BuildingEnitity.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 08/05/23.
//

import Foundation

import CoreData

extension BuildingEntity {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<BuildingEntity>{
        let request = NSFetchRequest<BuildingEntity>(entityName: "BuildingEntity")
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        return request
    }
    
    func convertToUser() -> Building {
        Building(id: Int32(self.id), code: self.code!, name: self.name!)
    }
    
}
