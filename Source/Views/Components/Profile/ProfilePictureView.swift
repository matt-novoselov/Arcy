//
//  ProfilePictureView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct ProfilePictureView: View {
    
    var startTime = Date.now
    var showingShimmer: Bool = false
    
    var body: some View {
        
        TimelineView(.animation) { timeline in
            let elapsedTime = startTime.distance(to: timeline.date)
            
            Group{
                // MARK: Load image from persistence
    //            if let imagePath = Image(.placeholder){
    //                imagePath
    //                    .resizable()
    //            } else {
                Image(.profilePicturePlaceholder)
                    .interpolation(.high)
                    .resizable()
                    .scaledToFit()
    //            }
            }
            .clipShape(.circle)
            .scaledToFit()
                .visualEffect { content, proxy in
                    content
                        .colorEffect(
                            ShaderLibrary.shimmer(
                                .float2(proxy.size),
                                .float(elapsedTime),
                                .float(1.5),
                                .float(0.5),
                                .float(showingShimmer ? 0.5 : 0)
                            )
                        )
                }
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    ProfilePictureView(showingShimmer: true)
}
