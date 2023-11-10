//
//  LegendEntity.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 05/05/23.
//

import Foundation

import CoreData

extension LegendEntity {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<LegendEntity>{
        let request = NSFetchRequest<LegendEntity>(entityName: "LegendEntity")
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        return request
    }
    
    func convertToUser() -> Legend {
        Legend(id: Int32(self.id), code: self.code!, name: self.name!, nameEng: self.nameEng!)
    }
    
}
