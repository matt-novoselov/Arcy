//
//  CircleProgressBarView.swift
//  Arcy
//
//  Created by Matt Novoselov on 08/05/24.
//

import SwiftUI

struct CircularProgressView: View {
    
    @Binding var progress: Double
    
    let strokeWidth: Double = 20
    
    var adjustedProgress: Double{
        progress * 0.75
    }
    
    let myGradient = Gradient(
        colors: [
            Color(.iconPurple),
            Color(.iconBlue)
        ]
    )
    
    var body: some View {
        
        ZStack {
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(
                    .thickMaterial,
                    style: StrokeStyle(
                        lineWidth: strokeWidth,
                        lineCap: .round
                    )
                )
            
            Circle()
                .trim(from: 0, to: adjustedProgress)
                .stroke(
                    myGradient,
                    style: StrokeStyle(
                        lineWidth: strokeWidth,
                        lineCap: .round
                    )
                )
        }
        .rotationEffect(.degrees(135))
        
    }
}

#Preview {
    CircularProgressView(progress: .constant(1))
}
