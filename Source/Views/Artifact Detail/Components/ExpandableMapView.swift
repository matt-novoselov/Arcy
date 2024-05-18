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
        
        // Display main Map
        Map(initialPosition: position){
            
            // Display marker with the name of the city, where the artifact is located in
            Marker(selectedCity, systemImage: "scroll", coordinate: CLLocationCoordinate2D(latitude: selectedArtifact.location.latitude, longitude: selectedArtifact.location.longitude))
                .tint(.cyan)
            
        }
        
        // Apply standard map style
        .mapStyle(.standard(elevation: .realistic, pointsOfInterest: .excludingAll))
        
        // Hide all maps controls
        .mapControlVisibility(.hidden)
        
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
        
        .cornerRadius(20)

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
