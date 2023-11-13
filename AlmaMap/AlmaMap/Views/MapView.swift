//
//  MapView.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 04/05/23.
//

import Foundation
import SwiftUI
import SVGView

struct MapView: View {
    
    @ObservedObject var viewModel: DataLoader
    
    // FetchRequests per Buildings e Floors
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var buildingsCoreData: FetchedResults<BuildingEntity>
    
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var floorsCoreData: FetchedResults<FloorEntity>
    
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var spaceCoreData: FetchedResults<SpacesEntity>
    
    
   
    
    
    
    // Proprietà calcolate per costruire liste di Buildings e Floors
    private var buildings: [Building] {
        viewModel.building + buildingsCoreData.map { $0.convertToUser() }
    }
    
    private var floors: [Floor] {
        viewModel.floor + floorsCoreData.map { $0.convertToUser() }
    }
    
    private var spaces: [Spaces] {
        viewModel.space + spaceCoreData.map { $0.convertToUser() }
        
    }
    
    
    // MARK: - Utilities for the view
    @State  var active: String = "campus"
    @State  var buildingShow: Int32 = 0
    @State var isHidden: Bool = true
    @State var isHidden3: Bool = true
    @State var isHidden2: Bool = false
    @State var show: Bool = false

    
    // Limiti dello zoom
    private let maxZoomScale: CGFloat = 3.0
    private let minZoomScale: CGFloat = 0.5
    
    // Stati per la gestione dello zoom
    @State private var zoomScale: CGFloat = 1.0
    @GestureState private var pinchScale: CGFloat = 1.0
    
    // Computed-property per creare la MagnificationGesture
    private var magnificationGesture: some Gesture {
        MagnificationGesture()
            .updating($pinchScale) { value, state, _ in
                state = value
            }
            .onEnded { value in
                let newScale = zoomScale * value
                zoomScale = min(maxZoomScale, max(minZoomScale, newScale))
            }
    }
    
    // Funzione per configurare SVGView
    // Qui inserisci ogni gestione delle stanze supportate
    private func setupView(_ view: SVGView) -> SVGView {
        spaces.forEach { space in
            if let part = view.getNode(byId: space.code) {
                part.onTapGesture {
                    show = true
                }
            }
            
        }
        return view
       
    }
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack{
            setupView(SVGView(contentsOf: Bundle.main.url(forResource: active, withExtension: "svg")!))
                .contentShape(Rectangle()) // Fa si che tutto il rettangolo ascolto la gesture
                .scaleEffect(zoomScale * pinchScale)
                .gesture(magnificationGesture)
            
            VStack{
                HStack{
                        Button("back"){
                            isHidden2 = false
                            isHidden = true
                            isHidden3 = true
                            active = "campus"
                        }.padding(10).buttonBorderShape(.capsule).foregroundColor(Color.white).background(Color(hue: 0.0222, saturation: 1, brightness: 0.81)).cornerRadius(.infinity)
                    Spacer()
                }.isHidden(hidden: isHidden, remove: true).padding()
                
                Spacer()
                HStack{
                    ForEach(buildings) { building in
                        Button(building.code){
                            zoomScale = 1.0
                            
                            isHidden = false
                            isHidden3 = false
                            isHidden2 = true
                            buildingShow = building.id
                            active = "Ue\(buildingShow)_0"
                        }.padding(20).buttonBorderShape(.capsule).foregroundColor(Color.white).background(Color(hue: 0.0222, saturation: 1, brightness: 0.81)).cornerRadius(.infinity)
                    }.isHidden(hidden: isHidden2, remove: true).padding(10)
                }
                HStack{
                    ForEach(floors){ floor in
                        if(floor.buildingId == buildingShow){
                            Button(String(floor.number)){
                                zoomScale = 1.0
                                isHidden = false
                                isHidden2 = true
                                active = "Ue\(buildingShow)_\(floor.number)"
                            }.padding(10).buttonBorderShape(.capsule).foregroundColor(Color.white).background(Color(hue: 0.0222, saturation: 1, brightness: 0.81)).cornerRadius(.infinity)
                        }
                        
                    }
                }.isHidden(hidden: isHidden3, remove: true).padding()
              
                }
                
            }

            
        }
        
    }




struct IsHidden: ViewModifier {
    var hidden = false
    var remove = false
    func body(content: Content) -> some View {
        if hidden {
            if remove {
                
            } else {
                content.hidden()
            }
        } else {
            content
        }
    }
}


extension View {
    func isHidden(hidden: Bool = false, remove: Bool = false) -> some View {
        modifier(
            IsHidden(
                hidden: hidden,
                remove: remove))
    }
}



