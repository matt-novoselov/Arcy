//
//  GuessGameButton.swift
//  Arcy
//
//  Created by Matt Novoselov on 06/05/24.
//

import SwiftUI

struct GuessGameButton: View {
    
    // Name of the artifact for button
    let singleArtifact: String
    
    // Artifact that users needs to guess
    let hiddenArtifact: Artifact
    
    // Property that stores the name of the answer that user selected
    @Binding var selectedAnswer: String?
    
    @Binding var countCorrectAnswers: Int
    
    private var buttonHighlighted: Bool {
        return withAnimation(.none){
            (selectedAnswer != nil && singleArtifact == hiddenArtifact.name || singleArtifact == selectedAnswer)
        }
    }
    
    var body: some View {
        Button(action: {
            withAnimation{
                selectedAnswer=singleArtifact
            }
            
            if selectedAnswer == hiddenArtifact.name{
                countCorrectAnswers+=1
            }
        }, label: {
            Text(singleArtifact)
                .font(.title)
                .padding()
                .frame(maxWidth: .infinity)
                .opacity(buttonHighlighted ? 0 : 1)
                .animation(.none, value: buttonHighlighted)
        })
        .disabled(selectedAnswer != nil)
        
        // Highlight correct answer
        .background(selectedAnswer != nil && singleArtifact == hiddenArtifact.name ? Color.green : Color.clear)
        
        // Highlight incorrect answer
        .background(selectedAnswer != nil && singleArtifact == selectedAnswer && selectedAnswer != hiddenArtifact.name ? Color.red : Color.clear)
        
        .clipShape(.capsule)
        
        // Highlight correct answer
        .shadow(color: selectedAnswer != nil && singleArtifact == hiddenArtifact.name ? Color.green : Color.clear, radius: 10)
        
        // Highlight incorrect answer
        .shadow(color: selectedAnswer != nil && singleArtifact == selectedAnswer && selectedAnswer != hiddenArtifact.name ? Color.red : Color.clear, radius: 10)
        
        // Highlight correct and incorrect answers
        .overlay{
            if buttonHighlighted{
                Text(singleArtifact)
                    .font(.title)
                    .animation(.none, value: buttonHighlighted)
            }
        }
    }
}

#Preview {
    GuessGameButton(singleArtifact: "Test", hiddenArtifact: ArtifactsCollection().artifacts.first!, selectedAnswer: .constant(nil), countCorrectAnswers: .constant(0))
}
