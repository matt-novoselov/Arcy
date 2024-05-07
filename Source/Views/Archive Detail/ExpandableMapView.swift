//
//  ExpandableMapView.swift
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI
import MapKit

struct ExpandableMapView: View {
    
    @State private var isExpanded: Bool = false
    
    let latitude: Double
    let longitude: Double
    
    private let cornerRadius: Double = 20
    
    var body: some View {
        
        let position = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            )
        )
        
        ZStack(alignment: .bottom){
            Map(initialPosition: position)
                .mapStyle(.imagery)
                .scaledToFill()
                .onTapGesture {
                    if !isExpanded{
                        switchState()
                    }
                }
            .buttonBorderShape(.roundedRectangle(radius: cornerRadius))
            .frame(maxWidth: isExpanded ? .infinity : 400, maxHeight: isExpanded ? .infinity : 400)
            .hoverEffect()
            .hoverEffectDisabled(isExpanded)
            
            if isExpanded{
                Button(action: {switchState()}){
                    Label("Collapse", systemImage: "arrow.up.right.and.arrow.down.left")
                }
                .padding()
            }
            
        }
        .cornerRadius(cornerRadius)
        
    }
    
    func switchState(){
        withAnimation{
            isExpanded.toggle()
        }
    }
}
#Preview(windowStyle: .automatic) {
    ExpandableMapView(latitude: 0, longitude: 0)
}
