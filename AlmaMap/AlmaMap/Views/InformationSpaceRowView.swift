//
//  InformationSpaceRowView.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 08/11/23.
//

import Foundation
import Foundation
import SwiftUI

struct InformationSpaceRowView: View {
    
    var space: Spaces
    var sensor: Sensor
    @ObservedObject var viewModel: DataLoader
    
    
    @FetchRequest(sortDescriptors:  [], predicate: nil, animation: .default)
    private var SensorTypeCoreData: FetchedResults<SensorTypeEntity>
    
    var sensorTypes: [SensorType] {
        var list = viewModel.sensorType
        for sensorType in SensorTypeCoreData {
                list.append(sensorType.convertToUser())
        }
        return list
    }
    
   
    var body: some View {
        HStack {
            Text(viewModel.getSensorLable(type: sensor.typeCode))
            Spacer()
            VStack{
                let value = Simulator().simulateSensorValue(type: sensor.typeCode)
                Text(String(value) + " " + viewModel.getUnitCode(type: sensor.typeCode)).padding(20).background(viewModel.getColor(type: sensor.typeCode, value: value)).cornerRadius(10)
            }
                        
        }
    }
}

