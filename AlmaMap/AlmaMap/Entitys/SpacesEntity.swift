//
//  SpacesEntity.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 23/10/23.
//

import Foundation
import CoreData

extension SpacesEntity {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<SpacesEntity>{
        let request = NSFetchRequest<SpacesEntity>(entityName: "SpacesEntity")
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        return request
    }
    
    func convertToUser() -> Spaces {
        Spaces(id: Int32(self.id), code: self.code!, name: self.name!, descriptions: self.descriptions!, floorId: self.floorId, legendId: self.legendId)
    }
    
}
