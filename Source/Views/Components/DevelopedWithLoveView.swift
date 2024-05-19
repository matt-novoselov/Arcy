//
//  DevelopedWithLoveView.swift
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI

// This view is used in the credits section of the app to display information about the creator with an intractable heart
struct DevelopedWithLoveView: View {
    var body: some View {
        HStack(spacing: 5){
            Text("Developed with")
            
            // love (like button)
            DecorativeLikeButtonView()
            
            Text("by Matt Novoselov")
        }
        .font(.callout)
        .opacity(0.5)
    }
}

#Preview {
    DevelopedWithLoveView()
        .previewVariables()
}
