//
//  FloorRowView.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 09/05/23.
//

import SwiftUI

struct FloorRowView: View {
    
    var floor: Floor
    @ObservedObject var viewModel: DataLoader
    
    @FetchRequest(sortDescriptors:  [], predicate: nil, animation: .default)
    private var SpaceCoreData: FetchedResults<SpacesEntity>
    
    
    var spaces: [Spaces] {
        var list = viewModel.space
        for space in SpaceCoreData {
            list.append(space.convertToUser())
        }
        return list
    }
    @State private var showDetail = false
    
    var body: some View {
        VStack{
            
            Text(String(floor.number) + "° Piano")
            
            
        }
    }
}
