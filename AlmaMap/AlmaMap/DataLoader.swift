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
    
    var lastIdValues = 0
    @State var values = [String:Int]()
    
    @Published var model = Modeldata<Legend>(fileName: "legend")
    
    var legend: [Legend] {
        model.list
    }
    
    
    @Published var model2 = Modeldata<Building>(fileName: "buildings")
    
    var building: [Building] {
        model2.list
    }
    
    @Published var model3 = Modeldata<Floor>(fileName: "floors")
    
    var floor: [Floor] {
        model3.list
    }
    
    @Published var model4 = Modeldata<Spaces>(fileName: "spaces")
    
    var space: [Spaces] {
        model4.list
    }
    
    @Published var model5 = Modeldata<SensorType>(fileName: "sensor-types")
    
    var sensorType: [SensorType] {
        model5.list
    }
    
    
    @Published var model6 = Modeldata<Sensor>(fileName: "sensors")
    
    var sensor: [Sensor] {
        model6.list
    }
    
    
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
        values[type] = value
        
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
        
        
    }
    
    func addBuildings(viewContext: NSManagedObjectContext){
        for build in building {
            let newItem = BuildingEntity(context: viewContext)
            newItem.id = build.id
            newItem.code = build.code
            newItem.name = build.name
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func addFloors(viewContext: NSManagedObjectContext){
        for fl in floor {
            let newItem = FloorEntity(context: viewContext)
            newItem.id = fl.id
            newItem.svg = fl.svg
            newItem.buildingId = fl.buildingId
            newItem.number = fl.number
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    func addSpaces(viewContext: NSManagedObjectContext){
        for sp in space {
            let newItem = SpacesEntity(context: viewContext)
            newItem.id = sp.id
            newItem.code = sp.code
            newItem.descriptions = sp.descriptions
            newItem.floorId = sp.floorId
            newItem.legendId = sp.legendId
            newItem.name = sp.name
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    
    
    func newValue(sensor: Int32, value: Int, viewContext: NSManagedObjectContext){
        
        withAnimation {
            let newItem = SensorValueEntity(context: viewContext)
            newItem.id = Int32(lastIdValues + 1)
            newItem.idSensor = sensor
            newItem.value = Int32(value)
            lastIdValues += 1
            do {
                print(newItem)
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func getFloors(building: Int32, viewContext: NSManagedObjectContext) -> [Floor]{
        
        let request = NSFetchRequest<FloorEntity>(entityName: "FloorEntity")
        var list: [Floor] = []
        do{
            let resultUser = try viewContext.fetch(request)
            for resultUser in resultUser {
                if(resultUser.convertToUser().buildingId == building){
                    list.append(resultUser.convertToUser())
                }
            }
            return list
        } catch let fetchError{
            print("Faild to fetch: \(fetchError)")
        }
        
        return floor
    }
    
    func getSpaces(floor: Int32, viewContext: NSManagedObjectContext) -> [Spaces]{
        
        let request = NSFetchRequest<SpacesEntity>(entityName: "SpacesEntity")
        var list: [Spaces] = []
        do{
            let resultUser = try viewContext.fetch(request)
            for resultUser in resultUser {
                if(resultUser.convertToUser().floorId == floor){
                    list.append(resultUser.convertToUser())
                }
            }
            return list
        } catch let fetchError{
            print("Faild to fetch: \(fetchError)")
        }
        
        return space
    }
    
    func getBuildings(viewContext: NSManagedObjectContext) -> [Building] {
        let request = NSFetchRequest<BuildingEntity>(entityName: "BuildingEntity")
        var buildingList: [Building] = []

        do {
            let resultEntities = try viewContext.fetch(request)
            for buildingEntity in resultEntities {
                buildingList.append(buildingEntity.convertToUser())
            }
            return buildingList
        } catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }

        return buildingList
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

