//
//  Test3.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI
import RealityKit
import RealityKitContent
import MapKit

struct ArchiveDetailView: View {
    
    @State private var isLiked: Bool = false
    @State private var modelRotation = Angle.zero
    @State private var modelOpacity: Double = 0
    var artifact: Artifact
    
    var body: some View {
        
        ZStack(alignment: .trailing){
            HStack{
                ZStack(alignment: .bottom){
                    
                    Model3D(named: artifact.modelName) { model in
                        model
                            .resizable()
                            .scaledToFit()
                            .opacity(modelOpacity)
                            .rotation3DEffect(modelRotation, axis: .y)
                            .padding()
                            .onAppear(){
                                withAnimation(.interpolatingSpring(duration: 1.5)){
                                    modelRotation.degrees+=360
                                    modelOpacity = 1
                                }
                            }
                    } placeholder: {
                        ProgressView()
                            .frame(height: 300)
                    }
                    
                    Button(action: {}, label: {
                        Label("Exapnd", systemImage: "arrow.up.left.and.arrow.down.right")
                    })
                }
                .frame(height: 300)
                
                VStack(alignment: .leading){
                    Text("\(artifact.name) • \(artifact.ageOfCreation) BC")
                        .font(.largeTitle)
                    
                    Text(artifact.description)
                    
                    HStack{
                        ShareLink(item: URL(string: "https://apps.apple.com/us/app/light-speedometer/id6447198696")!) {
                            Image(systemName: "square.and.arrow.up")
                        }
                        
                        LikeButtonView(isLiked: $isLiked)
                    }
                    
                }
                .frame(width: 400)
                
                Rectangle()
                    .frame(width: 400, height: 400)
            }
            
            
            ExpandableMap()
        }
        
    }
}

struct ExpandableMap: View {
    
    @State var isExpanded: Bool = false
    
//    let position = MapCameraPosition.region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: selectedItem.location.latitude, longitude: selectedItem.location.longitude),
//            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//        )
//    )
//    
    var body: some View {
        

        ZStack(alignment: .bottom){
            Button(action: {switchState()}){
    //            Map(initialPosition: position)
                Map()
                    .mapStyle(.imagery)
                    .scaledToFill()
            }
            .buttonBorderShape(.roundedRectangle(radius: 20))
            .frame(maxWidth: isExpanded ? .infinity : 400, maxHeight: isExpanded ? .infinity : 400)
            
            if isExpanded{
                Button(action: {switchState()}){
                    Label("Collapse", systemImage: "arrow.up.right.and.arrow.down.left")
                }
                .padding()
            }

        }
        .cornerRadius(20)

        
    }
    
    func switchState(){
        withAnimation{
            isExpanded.toggle()
        }
    }
}

#Preview(windowStyle: .automatic) {
    ArchiveDetailView(artifact: Collection().artifacts.first!)
}
