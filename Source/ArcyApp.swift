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
    
    @State private var volumeModel = VolumeModelView()
    @State private var photoVM = PhotoViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environment(volumeModel)
                .environment(photoVM)
                .modelContainer(for: LikeModel.self)
        }
        
        ImmersiveSpace(id: "ConfettiImmersiveSpace") {
            ConfettiImmersive()
        }
        
        WindowGroup(id: "secondaryVolume") {
            VolumetricModelView()
                .environment(volumeModel)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.5, height: 0.5, depth: 0.5, in: .meters)
        
    }
}
