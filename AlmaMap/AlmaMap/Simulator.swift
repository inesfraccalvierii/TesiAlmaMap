//
//  Simulator.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 09/11/23.
//

import Foundation
import SwiftUI

struct Simulator {
    

    func isSummer() -> Bool{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        let month = components.month
        if (month! > 4 && month! <= 9){
            return true
        } else{
            return false
        }
    }
    
    func simulateTemperature() -> Int {
        if(isSummer()){
            return  Int.random(in: 23..<28)
        } else {
            return  Int.random(in: 18..<24)
        }
    }
    
    
    
    func simulateHumidity() -> Int {
        return  Int.random(in: 35..<65)
    }
    
    
    func simulateSound() -> Int {
        let distribution = Int.random(in: 0..<100)
        if(distribution > 40){
            return  Int.random(in: 35..<40)
        } else if (distribution > 20) {
            return  Int.random(in: 40..<65)
        } else {
            return  Int.random(in: 65..<75)
        }
    }
    
    
    func simulatePM25() -> Int {
        let distribution = Int.random(in: 0..<100)
        if(distribution > 20){
            return  Int.random(in: 0..<10)
        } else if (distribution > 5) {
            return  Int.random(in: 10..<25)
        } else {
            return  Int.random(in: 25..<30)
        }
    }
    
    func simulatePM10() -> Int {
        let distribution = Int.random(in: 0..<100)
        if(distribution > 20){
            return  Int.random(in: 0..<20)
        } else if (distribution > 5) {
            return  Int.random(in: 20..<50)
        } else {
            return  Int.random(in: 25..<30)
        }
    }
    
    func simulateNO2() -> Int {
        let distribution = Int.random(in: 0..<100)
        if(distribution > 20){
            return  Int.random(in: 0..<40)
        } else if (distribution > 5) {
            return  Int.random(in: 50..<150)
        } else {
            return  Int.random(in: 150..<200)
        }
    }
    
    func simulateO3() -> Int {
        let distribution = Int.random(in: 0..<100)
        if(distribution > 20){
            return  Int.random(in: 0..<50)
        } else if (distribution > 5) {
            return  Int.random(in: 50..<120)
        } else {
            return  Int.random(in: 120..<150)
        }
    }
    
    func simulateCO() -> Int {
        let distribution = Int.random(in: 0..<100)
        if(distribution > 20){
            return  Int.random(in: 0..<2000)
        } else if (distribution > 5) {
            return  Int.random(in: 2000..<10000)
        } else {
            return  Int.random(in: 10000..<12000)
        }
    }
    
    
    
    func simulateSensorValue(type: String) -> Int {
        
        
        switch type {
            case "TEMPERATURE":
                return simulateTemperature()
                
            case "HUMIDITY":
                return simulateHumidity()
            
            case "SOUND":
                return simulateSound()
            
            case "CARBON_MONOXIDE":
                return simulateCO()
                
            case "NITROGEN_DIOXIDE":
                return simulateNO2()
                
            case "OZONE":
                return simulateO3()
            
            case "PM2.5":
                return simulatePM25()
            
            case "PM10":
                return simulatePM10()
            
            default:
                return 0
            }
            
    }
    
    
}
