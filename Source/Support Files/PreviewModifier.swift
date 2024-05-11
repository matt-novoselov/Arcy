//
//  PreviewModifier.swift
//  Arcy
//
//  Created by Matt Novoselov on 11/05/24.
//

import SwiftUI

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
