//
//  GuessGameButton.swift
//  Arcy
//
//  Created by Matt Novoselov on 06/05/24.
//

import SwiftUI

// The guess game button represents one of the variants for answering in the guess artifact game
struct GuessGameButton: View {
    
    // Name of the artifact for button
    let singleArtifact: String
    
    // Artifact that users needs to guess
    let hiddenArtifact: Artifact
    
    // Property that stores the name of the answer that user selected
    @Binding var selectedAnswer: String?
    
    // Binding that counts how many times the user guessed the artifacts correctly
    @Binding var countCorrectAnswers: Int
    
    // Button will be highlighted in green, indicating the correct answer, after user selects a response
    private var highlightedCorrectly: Bool {
        selectedAnswer != nil && singleArtifact == hiddenArtifact.name
    }
    
    // Button will be highlighted in red, indicating the wrong answer, if user selects incorrect answer
    private var highlightedIncorrectly: Bool {
        selectedAnswer != nil && singleArtifact != hiddenArtifact.name && singleArtifact == selectedAnswer
    }
    
    var body: some View {
        Button(action: {
            // Make sure that the user can only answer one time
            if selectedAnswer == nil{
                withAnimation{
                    selectedAnswer=singleArtifact
                }
                
                // Adjust an amount of correctly answered questions
                if selectedAnswer == hiddenArtifact.name{
                    countCorrectAnswers+=1
                }
            }
        }, label: {
            Text(singleArtifact)
                .padding()
                .font(.title)
                .frame(maxWidth: .infinity)
        })
        
        // Disable button after user has posted a response
        .disabled(selectedAnswer != nil && !highlightedCorrectly && !highlightedIncorrectly)
        
        // Highlight correct answer
        .background(highlightedCorrectly ? Color.green : Color.clear, in: .capsule)
        
        // Highlight incorrect answer
        .background(highlightedIncorrectly ? Color.red : Color.clear, in: .capsule)
        
        // Highlight correct answer
        .shadow(color: highlightedCorrectly ? Color.green.opacity(0.5) : Color.clear, radius: 10)
        
        // Highlight incorrect answer
        .shadow(color: highlightedIncorrectly ? Color.red.opacity(0.5) : Color.clear, radius: 10)
    }
}

#Preview {
    GuessGameButton(singleArtifact: "Test", hiddenArtifact: ArtifactsCollection().artifacts.first!, selectedAnswer: .constant(nil), countCorrectAnswers: .constant(0))
        .previewVariables()
}
