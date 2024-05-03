//
//  UILottieView.swift
//  Linguine (iOS)
//
//  Created by Matt Novoselov on 25/04/24.
//

import SwiftUI

// This structure is used to represent Dot Lottie File in the SwiftUI View
struct UILottieView: View {
    
    // Pass the name of the Lottie file that is contained within the project
    var lottieName: String
    
    // Bool that controls if the animation should only be played once and stop
    var playOnce: Bool = false
    
    // Control the speed of playback of the animation
    var animationSpeed: Double = 1.0
    
    var body: some View {
        // Locate the Lottie file that is contained within the project
        if let fileURL = Bundle.main.url(forResource: lottieName, withExtension: "lottie"){
            LottieView(url: fileURL, playOnce: playOnce, animationSpeed: animationSpeed)
        }
        else{
            Text("Lottie not found")
                .foregroundStyle(.red)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    UILottieView(lottieName: "dog_main")
}
