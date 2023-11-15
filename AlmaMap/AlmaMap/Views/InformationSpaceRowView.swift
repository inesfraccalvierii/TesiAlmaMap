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
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors:  [], predicate: nil, animation: .default)
    private var SensorTypeCoreData: FetchedResults<SensorTypeEntity>
    
    var sensorTypes: [SensorType] {
        var list = viewModel.sensorType
        for sensorType in SensorTypeCoreData {
                list.append(sensorType.convertToUser())
        }
        return list
    }
    
    @State var values = [String:Int]()
   
    var body: some View {
        HStack {
            Text(viewModel.getSensorLable(type: sensor.typeCode))
            Spacer()
            VStack{
                let value = Simulator().simulateSensorValue(type: sensor.typeCode)
                //let _ = addValue(sensor: sensor.id, sensorname: sensor.typeCode, value: value)
                if( sensor.typeCode == "COMFORT"){
                    Text(String(viewModel.comfort()) + " " + viewModel.getUnitCode(type: sensor.typeCode)).padding(20).background(Color.white).cornerRadius(10)
                } else {
                    Text(String(value) + " " + viewModel.getUnitCode(type: sensor.typeCode)).padding(20).background(viewModel.getColor(type: sensor.typeCode, value: value)).cornerRadius(10)
                }
            }
                        
        }
    }
    
  /*  func addValue(sensor: Int32, sensorname: String, value:Int ){
        //viewModel.newValue(sensor: sensor, value: value, viewContext: viewContext)
        values[sensorname] = value
    }
    
    func comfort() -> Int{
        print(values.count)
        if(values.count == 8){
            let thermalIndex = Double(values["TEMPERATURE"]!) * 0.6 + Double(values["HUMIDITY"]!) * 0.4
            let soundIndex = Double(values["SOUND"]!)
            let airQualityIndex = max(Double(values["OZONE"]!), Double(values["PM2.5"]!), Double(values["CARBON_MONOXIDE"]!), Double(values["NITROGEN_DIOXIDE"]!), Double(values["PM10"]!))
            let comfortIndex = thermalIndex * 0.4 + soundIndex * 0.3 + airQualityIndex * 0.3
            let comfortPercentage = 100 - (comfortIndex * 100 / 2)
            values.removeAll()
            return Int(comfortPercentage)
        } else {
            return 50
        }
       
      
    }*/
}

