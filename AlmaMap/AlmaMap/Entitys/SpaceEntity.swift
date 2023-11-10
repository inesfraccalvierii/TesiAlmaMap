//
//  SpaceEntity.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 11/09/23.
//
 

import Foundation

import CoreData

extension SpaceEntity {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<SpaceEntity>{
        let request = NSFetchRequest<SpaceEntity>(entityName: "SpaceEntity")
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        return request
    }
    
    func convertToUser() -> Space {
        Space(id: Int32(self.id), code: self.code!, name: self.name!, descriptions: self.descriptions!, floorId: self.floorId, legendId: self.legendId)
    }
    
}

