//
//  PreviewModifier.swift
//  Arcy
//
//  Created by Matt Novoselov on 11/05/24.
//

import SwiftUI

// Custom modifier that simplifies work with SwiftUI Previews by injecting all necessary models and storage containers
// Note: Never use outside of the Preview scope
// Design ONLY for Previews purposes
struct PreviewVariables: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environment(PhotoViewModel())
            .environment(VolumeModelView())
            .modelContainer(for: LikeModel.self)
    }
}

extension View {
    func previewVariables() -> some View {
        self.modifier(PreviewVariables())
    }
}
