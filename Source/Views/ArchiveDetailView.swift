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
    var selectedItem: ArcheologicalItem
    
    var body: some View {
        
        HStack{
            ZStack(alignment: .bottom){
                
                Model3D(named: selectedItem.modelName) { model in
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
                Text("\(selectedItem.name) • \(selectedItem.ageOfCreation) BC")
                    .font(.largeTitle)
                
                Text(selectedItem.description)
                
                HStack{
                    ShareLink(item: URL(string: "https://apps.apple.com/us/app/light-speedometer/id6447198696")!) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    
                    LikeButtonView(isLiked: $isLiked)
                }
                
            }
            .frame(width: 400)
            
            let position = MapCameraPosition.region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: selectedItem.location.latitude, longitude: selectedItem.location.longitude),
                    span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                )
            )
            
            Button(action: {}){
                Map(initialPosition: position)
                    .mapStyle(.imagery)
                    .cornerRadius(20)
                    .scaledToFill()
            }
            .buttonBorderShape(.roundedRectangle(radius: 20))
            .frame(width: 400, height: 400)
            .padding()
            
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    ArchiveDetailView(selectedItem: ArcheologicalItemsCollection().items.first!)
}
