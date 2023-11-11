//
//  ButtonFloorView.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 10/11/23.
//

import Foundation
import SwiftUI

struct ButtonFloorview: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors:  [], predicate: nil, animation: .default)
    private var FloorsCoreData: FetchedResults<FloorEntity>
    
    @State  var building: Building
    
    var floors: [Floor] {
        var list = viewModel.floor
        for floor in FloorsCoreData {
            if(floor.buildingId == building.id){
                list.append(floor.convertToUser())
            }
           
        }
        return list
    }

    var body: some View {
        ZStack{
            
        }
        
    }
}


