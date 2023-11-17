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
    @Environment(\.managedObjectContext) private var viewContext
    
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
    @State var floorSelected: Int32 = 0
    @State var spaceSelect: Spaces
    
    
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
        spaces.forEach{ space in
            if let part = view.getNode(byId: getId(space: space.legendId, code: space.code)) as? SVGShape {
                part.fill = getLegendColor(type: space.legendId)
                part.onTapGesture {
                    spaceSelect = space
                    if(space.legendId != 6 && space.legendId != 7 && space.legendId != 8){
                        show = true
                    }
                }
            }
        }
        return view
        
    }
    
    
    
    
    private func getId(space: Int32, code: String) -> String{
        switch space {
        case 1:
            return "Aule_\(code)"
        case 2:
            return code
        case 3:
            return "Studi_\(code)"
        case 4:
            return "Servizi_\(code)"
        case 5:
            return "Bagni_\(code)"
        case 6:
            return "Scale_\(code)"
        case 7:
            return "Ascensori_\(code)"
        case 8:
            return "Uscite_\(code)"
        default:
            return ""
        }
    }
    // MARK: - Body
    
    
    var body: some View {
        
        VStack{
            Text("**AlmaMap**").font(.title).padding(.bottom, 20).foregroundColor(Color.white).frame(maxWidth: .infinity).background(Color(hue: 0.0222, saturation: 1, brightness: 0.81))
            
            ZStack{
                setupView(SVGView(contentsOf: Bundle.main.url(forResource: active, withExtension: "svg")!))
                    .contentShape(Rectangle()) // Fa si che tutto il rettangolo ascolto la gesture
                    .scaleEffect(zoomScale * pinchScale)
                    .gesture(magnificationGesture)
                
                VStack{
                    HStack{
                        Button("back"){
                            floorSelected = 0
                            isHidden2 = false
                            isHidden = true
                            isHidden3 = true
                            active = "campus"
                        }.padding(10).buttonBorderShape(.capsule).foregroundColor(Color.white).background(Color(hue: 0.0222, saturation: 1, brightness: 0.81)).cornerRadius(.infinity)
                        Text("**Ue\(buildingShow)**").font(.title2).frame(maxWidth: 250, alignment: .center)
                        Spacer()
                    }.isHidden(hidden: isHidden, remove: true).padding()
                    
                    Spacer()
                    HStack{
                        ForEach(viewModel.getBuildings(viewContext: viewContext)) { building in
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
                        ForEach(viewModel.getFloors(building: buildingShow, viewContext: viewContext)){ floor in
                            if(floor.buildingId == buildingShow){
                                Button(String(floor.number)){
                                    floorSelected = floor.number
                                    zoomScale = 1.0
                                    isHidden = false
                                    isHidden2 = true
                                    active = "Ue\(buildingShow)_\(floor.number)"
                                }.padding(10).buttonBorderShape(.capsule).foregroundColor(Color.white).background(AlmaMap.floorSelected(floorselected: floorSelected, floor: floor.number)).cornerRadius(.infinity)
                            }
                            
                        }
                    }.isHidden(hidden: isHidden3, remove: true).padding()
                    
                } .sheet(isPresented: $show) {
                    InformationSpaceView(space: spaceSelect, viewModel: viewModel).padding(.top)
                }
                
            }
            
            
        }
        
    }
}

func floorSelected(floorselected: Int32, floor: Int32) -> Color{
    if(floorselected == floor){
        return Color.orange
    }
    else{
        return Color(hue: 0.0222, saturation: 1, brightness: 0.81)
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
    
    func getLegendColor(type: Int32) -> SVGColor{
        
        switch type{
        case 5:
            return SVGColor.init(r: 77, g: 208, b: 225)
            
        case 1:
            return SVGColor.init(r: 239, g: 83, b: 80)
            
        case 2:
            return SVGColor.init(r: 255, g: 183, b:77)
            
        case 3:
            return SVGColor.init(r: 33, g: 150, b: 243)
            
        case 7:
            return SVGColor.init(r: 123, g: 222, b: 11)
            
        case 6:
            return SVGColor.init(r: 255, g: 252, b: 0)
            
        case 4:
            return SVGColor.init(r: 186, g: 104, b: 200)
            
        case 8:
            return SVGColor.init(r: 26, g: 175, b: 80)
            
            
        default:
            return SVGColor.init(r: 181, g: 84, b: 68)
        }
    }
    
}



