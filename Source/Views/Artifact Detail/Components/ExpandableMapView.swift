//
//  ExpandableMapView.swift
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI
import MapKit
import CoreLocation

// Expandable map can be expanded and collapsed by clicking on it
// The map is used in the Artifact Detail View to display information about the
struct ExpandableMapView: View {
    
    // Pass the artifact, information about which should be displayed in the Map
    let selectedArtifact: Artifact
    
    // Define corner radius for the map
    private let cornerRadius: Double = 20
    
    // Property that controls if the map is currently expanded
    @State private var isExpanded: Bool = false
    
    // Display information about the city, the artifact is located in
    @State private var selectedCity: String = ""
    
    var body: some View {
        
        // Define position for the Marker on the map based on the Artifact's latitude and longitude
        let position = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: selectedArtifact.location.latitude, longitude: selectedArtifact.location.longitude),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            )
        )
        
        ZStack(alignment: .bottom){
            
            // Display main Map
            Map(initialPosition: position){
                
                // Display marker with the name of the city, where the artifact is located in
                Marker(selectedCity, systemImage: "scroll", coordinate: CLLocationCoordinate2D(latitude: selectedArtifact.location.latitude, longitude: selectedArtifact.location.longitude))
                    .tint(.cyan)
                
            }
            
            // Apply standard map style
            .mapStyle(.standard(elevation: .realistic))
            
            // Hide all maps controls
            .mapControlVisibility(.hidden)
            
            // Expand map on the tap gesture, if it's currently collapsed
            .onTapGesture {
                if !isExpanded{
                    switchState()
                }
            }
            .frame(maxWidth: isExpanded ? .infinity : 400, maxHeight: isExpanded ? .infinity : 400)
            
            // Define button style and hover effect
            .buttonBorderShape(.roundedRectangle(radius: cornerRadius))
            .hoverEffect()
            
            // Disable hover effect if the map is expanded, because it can only be collapsed with a button
            .hoverEffectDisabled(isExpanded)
            
            // Try to locate country and city name of the Artifact by connecting to the Apple's reverse geocoding servers
            .onAppear(){
                lookUpCurrentLocation { placemark in
                    DispatchQueue.main.async {
                        // If the city and country are parsed successfully, display them in the following format:
                        // Example: New York, USA
                        if let city = placemark?.locality, let country = placemark?.country {
                            selectedCity = "\(city), \(country)"
                        } else if let country = placemark?.country{
                            // If the only country was parsed successfully, display info in the following format:
                            // Example: USA
                            selectedCity = country
                        }
                        // If none info was parsed successfully or the app doesn't have an internet connection. the Marker's title will be empty
                    }
                }
            }
            
            // Display collapse button when map is expanded
            if isExpanded{
                Button(action: {switchState()}){
                    Label("Collapse", systemImage: "arrow.up.right.and.arrow.down.left")
                }
                .padding()
            }
            
        }
        .cornerRadius(cornerRadius)
        
    }
    
    // Function to switch states of the map
    // Example: To switch from expanded to collapsed and in reverse
    func switchState(){
        withAnimation{
            isExpanded.toggle()
        }
    }
    
    // Function to locate country and city name of the Artifact by connecting to the Apple's reverse geocoding servers
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)  -> Void ) {
        
        // Initialize geocoder
        let geocoder = CLGeocoder()
        
        // Define position for the Marker on the map based on the Artifact's latitude and longitude
        let coordinates = CLLocation(latitude: selectedArtifact.location.latitude, longitude: selectedArtifact.location.longitude)
        
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(coordinates, completionHandler: { (placemarks, error) in
            if error == nil {
                // Extract information from the response
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
        .previewVariables()
}
