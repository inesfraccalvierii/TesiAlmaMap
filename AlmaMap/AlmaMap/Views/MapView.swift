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
    
    //    @State var scale = 1.0
    @State var lastscale = 1.0
    
    @GestureState private var scale: CGFloat = 0.0
    @State private var endScale: CGFloat = 1.0
    
    @FetchRequest(sortDescriptors:  [], predicate: nil, animation: .default)
    private var BuildingsCoreData: FetchedResults<BuildingEntity>
    
    
    var buildings: [Building] {
        var list = viewModel.building
        for building in BuildingsCoreData {
            list.append(building.convertToUser())
        }
        return list
    }
    
    @FetchRequest(sortDescriptors:  [], predicate: nil, animation: .default)
    private var FloorsCoreData: FetchedResults<FloorEntity>
    
    var floors: [Floor] {
        var list = viewModel.floor
        for floor in FloorsCoreData {
            list.append(floor.convertToUser())
            
        }
        return list
    }
    
    @State private var zoomScale: CGFloat = 1.0
    @GestureState private var pinchScale: CGFloat = 1.0
    
    
    var body: some View {
        
        let view = SVGView(contentsOf: Bundle.main.url(forResource: "Ue5_2", withExtension: "svg")!)
        if let part = view.getNode(byId: "Bagni_Ue5_2_Bagno03") {
            part.onTapGesture {
                part.opacity = 0.2
            }
        }
        return view.scaledToFit().scaleEffect(zoomScale * pinchScale)
            .gesture(
                MagnificationGesture()
                    .updating($pinchScale, body:{ value, state, _ in
                        state = value
                    })
                    .onEnded( { value in
                        zoomScale += value
                    })
            )
        
    }
}

/*
 VERSIONE CORRETTA
 
 view.scaledToFit().scaleEffect(zoomScale * pinchScale)
     .gesture(
         MagnificationGesture()
             .updating($pinchScale, body:{ value, state, _ in
                 state = value.magnitude
             })
             .onEnded( { value in
                 zoomScale += value.magnitude
             })
     ).animation(.easeOut, value: endScale)

 
 */



/*
 
 ZStack{
 VStack{
 Image("Campus")
 //.resizable()
 .scaledToFit()
 .scaleEffect(scale + endScale)
 .gesture(
 MagnificationGesture()
 .updating($scale, body: { value, state, transaction in
 state = value.magnitude
 })
 .onEnded({ value in
 endScale += value.magnitude
 })
 )
 .animation(.easeOut, value: endScale)
 }
 Spacer()
 VStack{
 ForEach(buildings) { building in
 Button(building.code){
 
 }.padding(10).buttonBorderShape(.capsule).background(Color(red: 203/255, green: 203/255, blue: 203/255)).cornerRadius(.infinity)
 }
 
 }
 }
 
 struct MapView_Previews: PreviewProvider {
 static var previews: some View {
 MapView(viewModel: DataLoader)
 
 }
 }
 
 Image("Campus")
 .resizable()
 .scaledToFit()
 .scaleEffect(scale + endScale)
 .gesture(
 MagnificationGesture()
 .updating($scale, body: { value, state, transaction in
 state = value.magnitude
 })
 .onEnded({ value in
 endScale += value.magnitude
 })
 )
 .animation(.easeOut, value: endScale)
 */
