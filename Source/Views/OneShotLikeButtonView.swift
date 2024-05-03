//
//  OneShotLikeButtonView.swift
//  Arcy
//
//  Created by Matt Novoselov on 04/05/24.
//

import SwiftUI

struct OneShotLikeButtonView: View {
    
    @State var emittingParticles: Bool = false
    
    var body: some View {
        Button(action: {
            emitParticles()
        }){
            Image(systemName: "heart.fill")
                .foregroundStyle(.white)
                .symbolEffect(.bounce, value: emittingParticles)
                .padding()
                .overlay{
                    if emittingParticles{
                        UILottieView(lottieName: "like_animation_white", playOnce: true)
                            .allowsHitTesting(false)
                    }
                }
        }
        .buttonStyle(.plain)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                emitParticles()
            }
        }
    }
    
    func emitParticles(){
        withAnimation(.none){
            emittingParticles = true
        } completion: {
            emittingParticles = false
        }
    }
}

#Preview {
    OneShotLikeButtonView()
}
