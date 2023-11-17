//
//  BuildingsView.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 05/05/23.
//

import Foundation
import SwiftUI



struct BuildingsView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors:  [], predicate: nil, animation: .default)
    private var BuildingsCoreData: FetchedResults<BuildingEntity>
    @State  var building: Building
    
    @FetchRequest(sortDescriptors:  [], predicate: nil, animation: .default)
    private var FloorsCoreData: FetchedResults<FloorEntity>
    
    
    var buildings: [Building] {
        var list = viewModel.building
        for building in BuildingsCoreData {
            list.append(building.convertToUser())
        }
        return list
    }
    
    var floors: [Floor] {
        var list = viewModel.floor
        for floor in FloorsCoreData {
                list.append(floor.convertToUser())
        }
        return list
    }

    var body: some View {
        NavigationView(){
            List(viewModel.getBuildings(viewContext: viewContext)){ building in
                NavigationLink(destination: FloorView(viewModel: viewModel, building: building)){
                    Text(building.name)
                }
            }
        }
    }
}


/*NavigationView(){
      List{
          ForEach(buildings) { building in
              Section(header: Text(building.name)){
                  ForEach(floors) { floor in
                      if (floor.buildingId == building.id){
                          NavigationLink(destination: SpaceView(viewModel: viewModel, floor: floor)){
                              Text(String(floor.number) + "° Piano")
                          }
                      }
                  }
              }
          }
      }
  }*/
