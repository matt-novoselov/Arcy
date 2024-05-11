//
//  LikeButtonView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI
import SwiftData

struct LikeButtonView: View {
    
    @State private var isLiked: Bool = false
    
    @Environment(\.modelContext) private var context
    
    @Query private var storedLikedArtifacts: [LikeModel]
    
    @State private var wasInteracted: Bool = false
    @State private var wasInteractedSymbol: Bool = false

    let artifactID: Int
    
    var body: some View {
        
        Button(action: {
            wasInteractedSymbol.toggle()
            wasInteracted=true
            withAnimation(.none){
                updateLike()
                isLiked.toggle()
            }
        }, label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .foregroundStyle(isLiked ? .redPastel : .white)
                .symbolEffect(.bounce, value: wasInteractedSymbol)
        })
        
        // Add Lottie animation
        .overlay{
            if isLiked {
                UILottieView(lottieName: "like_animation", playOnce: true)
                    .padding(.all, -20)
                    .allowsHitTesting(false)
                    .opacity(wasInteracted ? 1 : 0)
            }
        }
        
        .onAppear() {
            withAnimation(.none){
                isLiked = getInitValue()
            }
        }
        
    }
    
    func getInitValue() -> Bool {
        if let matchedItem = storedLikedArtifacts.first(where: { $0.artifactID == self.artifactID }) {
            return matchedItem.isLiked
        } else{
            return false
        }
    }
    
    func updateLike() {
        // Check if an item with the given artifactID exists
        if let existingItem = storedLikedArtifacts.first(where: { $0.artifactID == artifactID }) {
            // If it exists, toggle the like status
            existingItem.isLiked.toggle()
        } else {
            // If it doesn't exist, create a new item with isLiked set to true
            let newItem = LikeModel(artifactID: artifactID, isLiked: true)
            context.insert(newItem)
        }
    }
}

#Preview(windowStyle: .automatic) {
    LikeButtonView(artifactID: 1000)
        .modelContainer(for: LikeModel.self)
}
