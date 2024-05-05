//
//  BackgroundGradientView.swift
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI

struct BackgroundGradientView: View {
    
    var elapsedTime: Double
    
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
