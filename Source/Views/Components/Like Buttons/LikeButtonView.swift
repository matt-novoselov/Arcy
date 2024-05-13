//
//  LikeButtonView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI
import SwiftData

// Like button is used in Artifacts cards and inside of the Detail View
// Like Button works directly with Swift Data and saves information about what Artifacts were liked by user
struct LikeButtonView: View {
    
    // Load Swift Data model from passed environment
    @Environment(\.modelContext) private var context
    
    // Extract information about Artifacts that are already liked from the Swift Data
    @Query private var storedLikedArtifacts: [LikeModel]
    
    // Property that controls if the button is liked or not
    // Automatically extracted from Swift Data on the load
    @State private var isLiked: Bool = false
    
    // Lottie files animations and SF Symbols animations are controlled differently, thus 2 variables for animation are needed
    
    // Property that controls if particles Lottie animation should be displayed
    // Note: particles Lottie animation should only be displayed when user taps on the button and only when the button state is about to turn to isLiked
    // Animation should not be played on appear when button loads information from the SwiftData
    // Animation should not be played when user "unlikes" the button
    @State private var particlesDisplayed: Bool = false
    
    // Property that toggles when the user taps on the button
    // Used for SF Symbol animation
    @State private var playbackSymbolAnimation: Bool = false
    
    // Pass ID of an artifact to which this like button is related
    // Starts from 0
    let artifactID: Int
    
    var body: some View {
        
        // Perform animation playback and like storage on tap of the button
        Button(action: {
            likeAction()
        }, label: {
            // Display SF Symbol with animation
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .foregroundStyle(isLiked ? .redPastel : .white)
                .symbolEffect(.bounce, value: playbackSymbolAnimation)
        })
        
        // Lottie animation view
        .overlay{
            // Display animation only when the button isLiked
            if isLiked {
                UILottieView(lottieName: "like_animation", playOnce: true)
                    .padding(.all, -20)
                    .allowsHitTesting(false)
                
                    // Hide animation if the "like action" was not invoked by the user interaction directly
                    .opacity(particlesDisplayed ? 1 : 0)
            }
        }
        
        // Parse initial value from the Swift Data
        // Animations should not be played on appear
        .onAppear() {
            withAnimation(.none){
                isLiked = getInitialValue()
            }
        }
        
    }
    
    // Perform like action animations and update information in the Swift Data storage
    func likeAction(){
        
        // Playback animation for SF Symbol
        playbackSymbolAnimation.toggle()
        
        // Display animation for Lottie particles
        particlesDisplayed=true
        
        withAnimation(.none){
            // Update information in the SwiftData
            updateLikeStorage()
            
            // Toggle the decorative state of the button
            isLiked.toggle()
        }
    }
    
    // Function to get the initial value of like from the Swift Data storage
    func getInitialValue() -> Bool {
        // If the Artifact ID already stored in SwiftData, return the like value
        if let matchedItem = storedLikedArtifacts.first(where: { $0.artifactID == self.artifactID }) {
            return matchedItem.isLiked
        } else{
            // Otherwise return false, meaning that the Artifact is not liked by default
            return false
        }
    }
    
    // Function to update the state of the button in the Swift Data
    func updateLikeStorage() {
        // Check if an item with the given artifactID exists
        if let existingItem = storedLikedArtifacts.first(where: { $0.artifactID == artifactID }) {
            // If it exists, toggle the like status
            existingItem.isLiked.toggle()
        } else {
            // If it doesn't exist, create a new item with isLiked set to true
            let newItem = LikeModel(artifactID: artifactID, isLiked: true)
            context.insert(newItem)
        }
    }
}

#Preview(windowStyle: .automatic) {
    LikeButtonView(artifactID: 0)
        .previewVariables()
}
