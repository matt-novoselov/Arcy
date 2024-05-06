//
//  BackgroundGradientView.swift
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI

struct BackgroundGradientView: View {
    
    // Pass time elapsed since appear of the view
    // The time should be passed from the outside to ensure that it is persistent between different scenes
    let elapsedTime: Double
    
    var body: some View {
        
        Rectangle()
            .opacity(0.7)
            .visualEffect { content, proxy in
                content
                    .colorEffect(
                        ShaderLibrary.sinebow(
                            .float2(proxy.size),
                            .float(elapsedTime)
                        )
                    )
            }
            .blur(radius: 150.0)
        
    }
}
