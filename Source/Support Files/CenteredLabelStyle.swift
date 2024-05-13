//
//  CenteredLabelStyle.swift
//  Arcy
//
//  Created by Matt Novoselov on 04/05/24.
//

import SwiftUI

// This custom label style is needed, because sometimes there is a SwiftUI bug, which leads to icon and text in the Label to be misaligned
// Usage example:
// Label("My label", systemImage: "xmark")
//    .labelStyle(CenteredLabelStyle())
struct CenteredLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        // Center label properly
        HStack {
            configuration.icon
            configuration.title
        }
    }
}
