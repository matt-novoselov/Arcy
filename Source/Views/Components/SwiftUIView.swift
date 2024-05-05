//
//  SwiftUIView.swift
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var startTime = Date.now

    var body: some View {
        
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)
            
            Circle()
                .foregroundStyle(.red)
                .visualEffect { content, proxy in
                    content
                        .colorEffect(
                            ShaderLibrary.shimmer(
                                .float2(proxy.size),
                                .float(elapsedTime),
                                .float(1.5),
                                .float(0.5),
                                .float(0.5)
                            )
                        )
                }
        }
        
    }
}

#Preview {
    SwiftUIView()
}
