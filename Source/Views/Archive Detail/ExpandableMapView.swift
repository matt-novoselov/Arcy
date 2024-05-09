//
//  ExpandableMapView.swift
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct ExpandableMapView: View {
    
    @State private var isExpanded: Bool = false
    
    let selectedArtifact: Artifact
    
    private let cornerRadius: Double = 20
    
    @State private var selectedCity: String = ""
    
    var body: some View {
        
        let position = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: selectedArtifact.location.latitude, longitude: selectedArtifact.location.longitude),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            )
        )
        
        ZStack(alignment: .bottom){
            Map(initialPosition: position){
                Marker(selectedCity, systemImage: "scroll", coordinate: CLLocationCoordinate2D(latitude: selectedArtifact.location.latitude, longitude: selectedArtifact.location.longitude))
                    .tint(.cyan)
            }
            .edgesIgnoringSafeArea(.all)
            .mapStyle(.standard(elevation: .realistic))
            .scaledToFill()
            .onTapGesture {
                if !isExpanded{
                    switchState()
                }
            }
            .frame(maxWidth: isExpanded ? .infinity : 400, maxHeight: isExpanded ? .infinity : 400)
            .buttonBorderShape(.roundedRectangle(radius: cornerRadius))
            .hoverEffect()
            .hoverEffectDisabled(isExpanded)
            .background(.red)
            
            .onAppear(){
                lookUpCurrentLocation { placemark in
                    DispatchQueue.main.async {
                        if let city = placemark?.locality, let country = placemark?.country {
                            selectedCity = "\(city), \(country)"
                        } else if let country = placemark?.country{
                            selectedCity = country
                        }
                    }
                }
            }
            
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
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)  -> Void ) {
        // Use the last reported location.
        let geocoder = CLGeocoder()
        
        let coordinates = CLLocation(latitude: selectedArtifact.location.latitude, longitude: selectedArtifact.location.longitude)
        
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(coordinates,
                                        completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                completionHandler(firstLocation)
            }
            else {
                // An error occurred during geocoding.
                completionHandler(nil)
            }
        })
    }
}
#Preview(windowStyle: .automatic) {
    ExpandableMapView(selectedArtifact: ArtifactsCollection().artifacts.first!)
}
