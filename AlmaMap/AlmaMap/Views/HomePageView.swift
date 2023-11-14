//
//  HomePageView.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 04/05/23.
//


import Foundation
import SwiftUI



struct HomePageView: View {
    
    @ObservedObject var viewModel: DataLoader
    @Environment(\.managedObjectContext) private var viewContext
    init(viewModel: DataLoader) { 
        self.viewModel = viewModel
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor(hue: 0.0222, saturation: 1, brightness: 0.81, alpha: 1.0)
        }
  
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var spaceCoreData: FetchedResults<SpacesEntity>
    private var spaces: [Spaces] {
        viewModel.space + spaceCoreData.map { $0.convertToUser() }
        
    }

    var body: some View {
      
            TabView{
                MapView(viewModel: viewModel, spaceSelect: spaces.first!).tabItem(){
                    Image(systemName: "globe.europe.africa")
                    Text("Mappa")
                }
                BuildingsView(viewModel: viewModel, building: viewModel.building.first!).tabItem(){
                    Image(systemName: "building.2.crop.circle")
                    Text("Edifici")
                }
                LegendView(viewModel: viewModel, legend: viewModel.legend.first!).tabItem(){
                    Image(systemName: "book.circle")
                    Text("Legenda")
                }
            }
            .accentColor(Color.black)
                .navigationTitle("AlmaMap").navigationBarBackButtonHidden(true).navigationBarTitleDisplayMode(.inline)
        
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(viewModel: DataLoader())
    }
}

