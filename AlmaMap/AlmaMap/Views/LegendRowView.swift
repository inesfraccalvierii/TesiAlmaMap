//
//  LegendRowView.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 05/05/23.
//

import Foundation
import SwiftUI


struct LegendRowView: View {
    
    var legend: Legend
    
    @ObservedObject var viewModel: DataLoader
    
    var body: some View {
        
        HStack {
            switch legend.code{
            case "toilette":
                Image("toilette").resizable().frame(width: 40, height: 40)
                
            case "exits":
                Image("exit").resizable().frame(width: 40, height: 40)
                
            case "classrooms":
                Image("classrooms").resizable().frame(width: 40, height: 40)
            
            case "labs":
                Image("labs").resizable().frame(width: 40, height: 40)
            
            case "studies":
                Image("studies").resizable().frame(width: 40, height: 40)
                
            case "elevators":
                Image("elevators").resizable().frame(width: 40, height: 40)
                
            case "stairs":
                Image("stairs").resizable().frame(width: 40, height: 40)
                
            case "services":
                Image("services").resizable().frame(width: 40, height: 40)
                
            
            default:
                Text("err")
            }
            
            VStack{
                
                Text(legend.name)
                Text(legend.nameEng).italic().foregroundColor(.gray)
            }.padding()
        }
    }
}

