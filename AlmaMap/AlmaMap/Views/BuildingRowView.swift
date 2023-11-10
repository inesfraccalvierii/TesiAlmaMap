//
//  BuildingRowView.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 08/06/23.
//

import Foundation
import SwiftUI

struct BuildingRowView: View {
    
    var building: Building
    @ObservedObject var viewModel: DataLoader
    var body: some View {
        HStack {
            Text(building.name)
        }
    }
}

