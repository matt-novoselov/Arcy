//
//  DevelopedWithLoveView.swift
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI

struct DevelopedWithLoveView: View {
    var body: some View {
        HStack(spacing: 5){
            Text("Developed with")
            
            OneShotLikeButtonView()
            
            Text("by Matt Novoselov")
        }
        .font(.caption)
        .opacity(0.5)
    }
}

#Preview {
    DevelopedWithLoveView()
}
