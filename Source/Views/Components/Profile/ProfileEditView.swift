//
//  ProfileEditView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI
import PhotosUI

// Profile edit View lets users to change their profile picture and name
struct ProfileEditView: View {
    
    // Load model for managing photo data and interactions
    @Environment(PhotoViewModel.self)
    private var photoViewModel
    
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
        
        VStack{
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
                // Save image to persistence
                Task {
                    // Try to load the transferable data of type Data from photoItem asynchronously
                    if let loaded = try? await photoItem?.loadTransferable(type: Data.self) {
                        // If data is successfully loaded, try to create a UIImage from the loaded data
                        if let savableImage = UIImage(data: loaded) {
                            // If UIImage is successfully created, compress the image and save it
                            if let compressedImage = UIImage(data: savableImage.jpegData(compressionQuality: 0.5) ?? Data()) {
                                photoViewModel.saveImage(compressedImage)
                            } else {
                                // If compression fails, print an error message
                                print("Failed to compress Data")
                            }
                        } else {
                            // If transformation to UIImage fails, print an error message
                            print("Failed to transform Data to UIImage")
                        }
                    } else {
                        // If loading data fails, print an error message
                        print("Failed to load Data from Photos Picker")
                    }
                }
                
                // Play shimmer effect after changing the photo
                playShimmerEffect()
            }
            
            // Text field to enter the user name
            TextField("Your name", text: $textInput.animation())
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .clipShape(.capsule)
                .padding(.vertical)
            
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
        .padding()
        
    }
    
    // Function to play shimmer effect
    func playShimmerEffect(){
        showingShimmer = true
        shimmerStartTime = Date.now
    }
    
}

#Preview(windowStyle: .automatic) {
    ProfileEditView(showingShimmerOnAppear: true)
        .previewVariables()
}
