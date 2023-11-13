//
//  DataLoader.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 05/05/23.
//

import Foundation
import SwiftUI
import CoreData

class DataLoader: ObservableObject {

    
    @Published var model = Modeldata<Legend>(fileName: "legend")
    
    var legend: [Legend] {
        model.list
    }
    
    //var isLoading = true
   

    @Published var model2 = Modeldata<Building>(fileName: "buildings")
    
    var building: [Building] {
        model2.list
    }
    
   // var isLoading2 = true
    
    
    @Published var model3 = Modeldata<Floor>(fileName: "floors")
    
    var floor: [Floor] {
        model3.list
    }
    
   // var isLoading3 = true
    
    @Published var model4 = Modeldata<Spaces>(fileName: "spaces")
    
    var space: [Spaces] {
        model4.list
    }
    
   // var isLoading4 = true
    
    @Published var model5 = Modeldata<SensorType>(fileName: "sensor-types")
    
    var sensorType: [SensorType] {
        model5.list
    }
    
   // var isLoading5 = true
    
    
    @Published var model6 = Modeldata<Sensor>(fileName: "sensors")
    
    var sensor: [Sensor] {
        model6.list
    }
    
   // var isLoading6 = true
    
    @Published var model7 = Modeldata<Unit>(fileName: "units")
    
    var unit: [Unit] {
        model7.list
    }
    
    var isLoading = true
    
    @Published var images: [String: UIImage] = [:]
    
    func loadImage(imageName:String, id: String) {
        images[id] = UIImage(named: imageName)!
        isLoading = false
    }
    
    let notFoundImage =  UIImage(named: "UserImg")
    
    func loadImage(url: URL, id: String) {
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = data {
                    self.images[id] = UIImage(data: imageData)!
                    self.isLoading = false
                }
            }
        }
    }


    var lastID: Int {
        UserDefaults.standard.integer(forKey: "lastID")
    }
    
    @FetchRequest(sortDescriptors:  [], predicate: nil, animation: .default)
    private var SensorTypeCoreData: FetchedResults<SensorTypeEntity>
    
    var sensorTypes: [SensorType] {
        var list = sensorType
        for sensorType in SensorTypeCoreData {
                list.append(sensorType.convertToUser())
        }
        return list
    }
    
    
    
    @FetchRequest(sortDescriptors:  [], predicate: nil, animation: .default)
    private var UnitCoreData: FetchedResults<UnitEntity>
    
    var units: [Unit] {
        var list = unit
        for unit in UnitCoreData {
                list.append(unit.convertToUser())
        }
        return list
    }
    
    func getColor(type: String, value: Int) -> Color{
        switch type {
            case "COMFORT":
            return Color.white
            case "TEMPERATURE":
                if(value > 19 && value < 27){
                    return Color.green
                } else {
                    return Color.red
                }
            
            case "HUMIDITY":
                if(value > 39 && value < 61){
                    return Color.green
                } else {
                    return Color.red
                }
            
            case "SOUND":
                if(value > 34 && value < 46){
                    return Color.green
                } else if(value > 45 && value < 60){
                    
                }else {
                    return Color.orange
                }
                    return Color.red
            
            case "CARBON_MONOXIDE":
                return Color.white
                
            case "NITROGEN_DIOXIDE":
                return Color.white
                
            case "OZONE":
                return Color.white
            
            case "PM2.5":
                return Color.white
            
            case "PM10":
                return Color.white
            
            default:
            return Color.white
            }
        
    }
    
    
    
    func getUnitCode(type: String) -> String{
        var unit2: String = ""
        units.forEach(){ unit in
            sensorTypes.forEach(){ sensorType in
                if(type == sensorType.code && sensorType.unitCode == unit.code){
                    unit2 = unit.symbol
                }
            }
            
            
        }
        return unit2
           
    }
    
    func getSensorLable(type: String) -> String{
        switch type {
            case "COMFORT":
                return "Comfort"
            case "TEMPERATURE":
                return "Temperatura"
                
            case "HUMIDITY":
                return "Umidità"
            
            case "SOUND":
                return "Suono"
            
            case "CARBON_MONOXIDE":
                return "Monossido di Carbonio"
                
            case "NITROGEN_DIOXIDE":
                return "Diossido di Azoto"
                
            case "OZONE":
                return "Ozono"
            
            case "PM2.5":
                return "PM2.5"
            
            case "PM10":
                return "PM10"
            
            default:
                return "err"
            }
           
    }
    
    
    
    
    
    
}

