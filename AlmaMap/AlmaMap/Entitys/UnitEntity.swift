//
//  UnitEntity.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 09/11/23.
//

import Foundation
import Foundation
import CoreData

extension UnitEntity {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<UnitEntity>{
        let request = NSFetchRequest<UnitEntity>(entityName: "UnitEntity")
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        return request
    }
    
    func convertToUser() -> Unit {
        Unit(id: Int32(self.id), code: self.code!, symbol: self.symbol!)
    }
    
}
