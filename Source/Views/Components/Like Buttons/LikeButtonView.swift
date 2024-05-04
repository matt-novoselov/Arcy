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
        Button(action: {
            withAnimation(.none){
                isLiked.toggle()
            }
        }, label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .foregroundStyle(isLiked ? .redPastel : .white)
                .symbolEffect(.bounce, value: isLiked)
        })
        .padding()
        .overlay{
            if isLiked{
                UILottieView(lottieName: "like_animation", playOnce: true)
                    .allowsHitTesting(false)
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    struct Preview: View {
        @State var isLiked: Bool = false
        var body: some View {
            LikeButtonView(isLiked: $isLiked)
        }
    }

    return Preview()
}
