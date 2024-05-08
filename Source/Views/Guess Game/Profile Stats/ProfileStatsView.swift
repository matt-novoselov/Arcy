//
//  ProfileStats.swift
//  Arcy
//
//  Created by Matt Novoselov on 08/05/24.
//

import SwiftUI

struct ProfileStatsView: View {
    
    @Binding var progress: Double
    
    var body: some View {
        
        ProfilePictureView()
            .padding(.all, 30)
            .overlay{
                CircularProgressView(progress: $progress)
            }
        
    }
}

#Preview(windowStyle: .automatic) {
    ProfileStatsView(progress: .constant(0.5))
}
