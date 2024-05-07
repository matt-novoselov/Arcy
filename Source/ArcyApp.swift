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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: LikeModel.self)
        
        ImmersiveSpace(id: "ConfettiImmersiveSpace") {
            ConfettiImmersive()
        }
    }
}
