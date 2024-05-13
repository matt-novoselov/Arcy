//
//  LottieView.swift
//  Arcy
//
//  Created by Matt Novoselov on 04/05/24.
//

import SwiftUI
import Lottie

// A SwiftUI view wrapper for Lottie animations.
struct LottieView: UIViewRepresentable {
    let url: URL // URL of the Lottie animation file
    var playOnce: Bool = false // Whether to play the animation once or loop
    var animationSpeed: Double = 1.0 // Speed at which the animation should play
    
    // Creates a new UIView instance to host the Lottie animation.
    func makeUIView(context: Context) -> some UIView {
        UIView()
    }
    
    // Updates the existing UIView with the Lottie animation.
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let animationView = LottieAnimationView() // Create a Lottie animation view
        animationView.translatesAutoresizingMaskIntoConstraints = false // Disable autoresizing mask
        uiView.addSubview(animationView) // Add the animation view to the parent view
        
        // Set constraints to make the animation view match the parent view's size
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: uiView.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: uiView.heightAnchor),
        ])
        
        // Load the Lottie animation file from the provided URL asynchronously
        DotLottieFile.loadedFrom(url: url) { result in
            switch result {
            case .success(let success): // If the animation loading is successful
                animationView.loadAnimation(from: success) // Load the animation
                if playOnce {
                    animationView.loopMode = .playOnce // Set loop mode to play once if specified
                } else {
                    animationView.loopMode = .loop // Set loop mode to loop indefinitely otherwise
                }
                animationView.play() // Start playing the animation
                animationView.animationSpeed = animationSpeed // Set animation speed
            case .failure(let failure): // If animation loading fails
                print(failure) // Print the error
            }
        }
    }
}
