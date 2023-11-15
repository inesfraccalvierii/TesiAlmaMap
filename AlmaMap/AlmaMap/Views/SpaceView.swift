//
//  SpaceView.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 12/09/23.
//


import Foundation
import SwiftUI

struct SpaceView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors:  [], predicate: nil, animation: .default)
    private var SpaceCoreData: FetchedResults<SpacesEntity>
    
    @State  var floor: Floor

  var spaces: [Spaces] {
        var list = viewModel.space
        for space in SpaceCoreData {
                list.append(space.convertToUser())
        }
        return list
    }
    
    
    @FetchRequest(sortDescriptors:  [], predicate: nil, animation: .default)
    private var LegendCoreData: FetchedResults<LegendEntity>
    
    var legends: [Legend] {
        var list = viewModel.legend
        for legend in LegendCoreData {
                list.append(legend.convertToUser())
        }
        return list
    }
    


    var body: some View {
            List(spaces) { space in
                if((space.legendId == 1 || space.legendId == 2 || space.legendId == 3 || space.legendId == 4) && space.floorId == floor.id ){
                        NavigationLink(destination: InformationSpaceView(space: space, viewModel: viewModel)){
                            SpaceRowView(space: space, viewModel: viewModel)
                        }
                    }
                    
            }.navigationTitle(String(floor.number) + "° Piano")
       

    }
    
}



