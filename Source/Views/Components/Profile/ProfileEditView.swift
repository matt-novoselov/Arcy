//
//  ProfileEditView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI
import PhotosUI

struct ProfileEditView: View {
    
    // Value for the textInput user name
    @State private var textInput: String = UserDefaults.standard.string(forKey: "userName") ?? ""
    
    // Profile photo picker
    @State private var photoItem: PhotosPickerItem?
    
    // Property that controls if photo picker selector is visible
    @State private var showingPhotoPicker: Bool = false
    
    // Property that controls if shimmer effect is visible
    // Can be enabled onAppear by padding true to showingShimmerOnAppear
    // By default shimmer effect happens when user changes the profile photo
    @State private var showingShimmer: Bool = false
    
    // Time in timeline when shimmer glance effect should be performed
    @State private var shimmerStartTime = Date.now
    
    // Property that defines if shimmer glance effect should be played on appear
    // Disabled by default
    var showingShimmerOnAppear: Bool = false
    
    var body: some View {
        
        // Button to trigger the photo picker
        Button(action: { showingPhotoPicker = true }) {
            ProfilePictureView(startTime: shimmerStartTime, showingShimmer: showingShimmer)
        }
        .buttonBorderShape(.circle)
        .frame(width: 300)
        
        // Integrates the PhotosPicker with the SwiftUI view hierarchy
        .photosPicker(isPresented: $showingPhotoPicker, selection: $photoItem, matching: .images)
        
        // Load the selected image
        .onChange(of: photoItem) {
            // MARK: Save image to persistence
            
            // Play shimmer effect
            playShimmerEffect()
        }
        
        // Text field to enter the user name
        TextField("Your name", text: $textInput.animation())
            .font(.largeTitle)
            .multilineTextAlignment(.center)
        
        // On change of the name, immediately save it to user defaults
            .onChange(of: textInput){
                UserDefaults.standard.set(textInput, forKey: "userName")
            }
        
        // Play shimmer effect on appear if specified
            .onAppear(){
                if showingShimmerOnAppear{
                    playShimmerEffect()
                }
            }
    }
    
    // Function to play shimmer effect
    func playShimmerEffect(){
        showingShimmer = true
        shimmerStartTime = Date.now
    }
    
}

#Preview(windowStyle: .automatic) {
    ProfileEditView(showingShimmerOnAppear: true)
}
