//
//  EndOfGameView.swift
//  Arcy
//
//  Created by Matt Novoselov on 06/05/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct EndOfGameView: View {
    
    // An amount of correctly answered questions by user
    var countCorrectAnswers: Int
    
    // An amount of XP that user gained during the game
    // The number is 0 by default, and being animated to a number of XP that user gained
    @State private var gainedXp: Int = 0
    
    // An amount of progress that user did during the game
    // A value from 0 to 1 that is used to display progress bar
    // To calculate the gained progress, divide an amount of correctly answered questions by maximum amount of questions that can be present in the game
    // The number is 0 by default, and being animated on appear after a slight delay
    @State private var gainedProgress: Double = 0
    
    // Get user score value from the user defaults
    @AppStorage("userXpScore") private var userXpScore: Int = 0
    
    // Environment variable to open Immersive space to display confetti
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    
    // Environment variable to close Immersive space to hide confetti
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var resetGame: () -> Void
    
    var body: some View {
        
        VStack{
            // Title
            Text("You did it!")
                .font(.title)
            
            // Profile statistics view is used to display statistics in the end of the game
            // The view indicates user's progress and how well he has performed during the game
            ProfileStatsView(progress: $gainedProgress)
                .padding(.all, 40)
                .overlay{
                    // Display an amount of XP user earned in the game
                    Text("+\(gainedXp) xp")
                        .font(.extraLargeTitle)
                        .contentTransition(.numericText())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
                .padding(.all, 50)
            
            // Button to exit back to page selection view
            Button("Play again", systemImage: "arrow.clockwise", action: {resetGame()})
                .labelStyle(CenteredLabelStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.all, 40)
        
        // Update score
        .onAppear(){
            
            // The base reward the user gets from the game, even if all of the answers are wrong
            let baseReward: Int = 5
            
            // Calculate a total amount of XP the user will receive
            let calculateXp = countCorrectAnswers * 20 + baseReward
            
            // Update the saved user score
            userXpScore+=calculateXp
            
            // Playback animations after a slight delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Playback XP amount animation
                withAnimation{
                    gainedXp = calculateXp
                }
                
                // Playback circular progress bar animation
                withAnimation(.spring(duration: 3)){
                    // Divide XP by a max amount of XP that can be possibly gained
                    gainedProgress = Double(countCorrectAnswers) / 3
                }
            }
        }
        
        // Present confetti
        .onAppear(){
            Task{
                await openImmersiveSpace(id: "ConfettiImmersiveSpace")
            }
        }
        
        // Hide confetti
        .onDisappear(){
            Task{
                await dismissImmersiveSpace()
            }
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    EndOfGameView(countCorrectAnswers: 3, resetGame: {})
        .previewVariables()
}
