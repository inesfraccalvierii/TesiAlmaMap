//
//  SpaceRowView.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 24/10/23.
//

import Foundation
import SwiftUI

struct SpaceRowView: View {
    
    var space: Spaces
    @ObservedObject var viewModel: DataLoader
    
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
        HStack {
            ForEach(legends) { legend in
                if(space.legendId == legend.id){
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
                }
            }
            
            Text(space.name)
        }
    }
}

