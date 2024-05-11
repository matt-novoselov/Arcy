//
//  ConfettiImmersive.swift
//  Arcy
//
//  Created by Matt Novoselov on 07/05/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ConfettiImmersive: View {
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Confetti", in: realityKitContentBundle) {
                content.add(scene)
            }
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ConfettiImmersive()
        .previewVariables()
}
