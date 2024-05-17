//
//  GameView.swift
//  Arcy
//
//  Created by Matt Novoselov on 06/05/24.
//

import SwiftUI

// Game View is responsible for keeping track of the game's state
struct GameView: View {
    
    // Property that controls the current level
    // By default game has 3 levels
    @State private var currentLevel: Int = 0
    
    // Property that counts how many times the user guessed the artifacts correctly
    @State private var countCorrectAnswers: Int = 0
    
    // Value to dismiss the current navigation link view
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
            VStack{
                
                // Custom toolbar visible during game phase
                if currentLevel < 3{
                    HStack{
                        // Back / Exit button
                        Button(action: {dismiss()}){
                            Image(systemName: "chevron.left")
                        }
                        .buttonBorderShape(.circle)
                        .help("Back")
                        
                        // Progress bar
                        // SF Symbol is used to enable adaptive frame size to match size of the back / exit button
                        Button(action: {}){
                            Image(systemName: "circle")
                                .frame(maxWidth: .infinity)
                        }
                        .tint(.clear)
                        .foregroundStyle(.clear)
                        .allowsHitTesting(false)
                        .overlay{
                            ProgressBar(progress: Double(currentLevel)/3)
                                .padding()
                        }
                    }
                    .padding(.all, 10)
                }
                
                // Control the current level based on the state of the game
                Group{
                    switch currentLevel {
                    case 0:
                        GuessArtifactView(nextButtonAction: {nextLevel()}, countCorrectAnswers: $countCorrectAnswers)
                    case 1:
                        GuessArtifactView(nextButtonAction: {nextLevel()}, countCorrectAnswers: $countCorrectAnswers)
                    case 2:
                        GuessArtifactView(nextButtonAction: {nextLevel()}, countCorrectAnswers: $countCorrectAnswers)
                    default:
                        EndOfGameView(countCorrectAnswers: countCorrectAnswers)
                    }
                }
                .frame(maxWidth: .infinity)
                .toolbar(.hidden)
                .transition(.pushLeftTransition)
            }
            .padding()
        
    }
    
    // Function to switch to the next level
    func nextLevel(){
        withAnimation{
            currentLevel+=1
        }
    }
}

#Preview(windowStyle: .automatic) {
    GameView()
        .previewVariables()
}
