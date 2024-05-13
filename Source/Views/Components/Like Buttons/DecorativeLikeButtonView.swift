//
//  OneShotLikeButtonView.swift
//  Arcy
//
//  Created by Matt Novoselov on 04/05/24.
//

import SwiftUI

// One shot like button is a decorative component that is used for displaying a heart with animation in the Profile View
struct DecorativeLikeButtonView: View {
    
    // Property that controls if the Lottie Animation particles should be played
    @State private var emittingParticles: Bool = false
    
    // Property that toggles when the user taps on the button
    // Used for SF Symbol animation
    @State private var buttonWasInteracted: Bool = false
    
    var body: some View {
        
        Button(action: {
            // Emit particles on button tap
            emitParticles()
        }){
            // Animate SF Symbol
            Image(systemName: "heart.fill")
                .foregroundStyle(.white)
                .symbolEffect(.bounce, value: buttonWasInteracted)
            
                // Lottie animation view
                .overlay{
                    if emittingParticles{
                        UILottieView(lottieName: "like_animation_white", playOnce: true)
                            .padding(.all, -20)
                            .allowsHitTesting(false)
                    }
                }
        }
        .buttonStyle(.plain)
        
        // Auto emit particles first time view appears, after 0.5 seconds
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                emitParticles()
            }
        }
        
    }
    
    // Function that controls particles emission
    func emitParticles(){
        
        // Play SF Symbol animation
        buttonWasInteracted.toggle()
        
        withAnimation(.none){
            // Playback Lottie particles animation
            emittingParticles = true
        } completion: {
            // Set property back to false after animation is complete
            emittingParticles = false
        }
    }
}

#Preview {
    DecorativeLikeButtonView()
        .previewVariables()
}
