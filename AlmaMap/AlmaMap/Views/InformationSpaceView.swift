//
//  InformationSpaceView.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 30/10/23.
//

import Foundation
import SwiftUI

struct InformationSpaceView: View {
    
    var space: Spaces
    @ObservedObject var viewModel: DataLoader
    
    @FetchRequest(sortDescriptors:  [], predicate: nil, animation: .default)
    private var SensorCoreData: FetchedResults<SensorEntity>
    
    var sensors: [Sensor] {
        var list = viewModel.sensor
        for sensor in SensorCoreData {
                list.append(sensor.convertToUser())
        }
        return list
    }
    
    var body: some View {
        VStack {
            Text(space.name)
            Text(space.descriptions)
            
            List(sensors) { sensor in
                if(sensor.spaceId == space.id) {
                        InformationSpaceRowView(space: space, sensor: sensor, viewModel: viewModel);

                }
            }
        }
    }
}

