//
//  ArcyApp.swift
//  Arcy
//
//  Created by Matt Novoselov on 20/04/24.
//

import SwiftUI
import SwiftData

@main
struct ArcyApp: App {
    
    // Initialize volume Model that is responsible for controlling what Artifact should currently be displayed in the 3D volume
    @State private var volumeModel = VolumeModelView()
    
    // Initialize photo View Model that is responsible for controlling and storing user Profile Picture
    @State private var photoViewModel = PhotoViewModel()
    
    var body: some Scene {
        
        // Main window is used for displaying main UI content
        WindowGroup {
            ContentView()
                .environment(volumeModel)
                .environment(photoViewModel)
                .modelContainer(for: LikeModel.self)
        }
        
        // Immersive Space is used for displaying Confetti in the end of the Game Session
        ImmersiveSpace(id: "ConfettiImmersiveSpace") {
            ConfettiImmersive()
        }
        
        // Volume is used for displaying 3D model of the Artifacts in the Detail View
        WindowGroup(id: "secondaryVolume") {
            VolumetricModelView()
                .environment(volumeModel)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.5, height: 0.5, depth: 0.6, in: .meters)
        
    }
}
