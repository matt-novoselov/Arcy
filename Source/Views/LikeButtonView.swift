//
//  LikeButtonView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct LikeButtonView: View {
    
    @Binding var isLiked: Bool
    
    var body: some View {
        Button(action: {isLiked.toggle()}, label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .foregroundStyle(isLiked ? .red : .white)
        })
    }
}

#Preview(windowStyle: .automatic) {
    LikeButtonView(isLiked: .constant(true))
}
