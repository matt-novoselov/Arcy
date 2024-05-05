//
//  CircleWave.swift
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI

struct CircleWave: View {
    @State private var startTime = Date.now

    var body: some View {
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)

            Circle()
                .padding()
                .drawingGroup()
                .visualEffect { content, proxy in
                    content
                        .colorEffect(
                            ShaderLibrary.circleWave(
                                .float2(proxy.size),
                                .float(elapsedTime),
                                .float(0.5),
                                .float(1),
                                .float(2),
                                .float(100),
                                .float2(0.5, 0.5),
                                .color(.blue)
                            )
                        )
                }
        }
    }
}

#Preview {
    CircleWave()
}
