//
//  OneShotLikeButtonView.swift
//  Arcy
//
//  Created by Matt Novoselov on 04/05/24.
//

import SwiftUI

struct OneShotLikeButtonView: View {
    
    @State private var emittingParticles: Bool = false
    @State private var emittedParticles: Bool = false
    
    var body: some View {
        
        Button(action: {
            emitParticles()
        }){
            Image(systemName: "heart.fill")
                .foregroundStyle(.white)
                .symbolEffect(.bounce, value: emittedParticles)
            
            // Lottie animation view
                .overlay{
                    if emittingParticles{
                        UILottieView(lottieName: "like_animation_white", playOnce: true)
                            .padding(.all, -20)
                            .allowsHitTesting(false)
                    }
                }
        }
        .buttonStyle(.plain)
        
        // Auto emit particles on appear
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                emitParticles()
            }
        }
        
    }
    
    func emitParticles(){
        emittedParticles.toggle()
        
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
