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
    
    var countCorrectAnswers: Int
    
    @State private var gainedXp: Int = 0
    
    @State private var gainedProgress: Double = 0
    
    // Get user score value from the user defaults
    @AppStorage("userXpScore") private var userXpScore: Int = 0
    
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        
        VStack{
            Text("You did it!")
                .font(.title)
            
            ProfileStatsView(progress: $gainedProgress)
                .padding(.all, 40)
                .overlay{
                    Text("+\(gainedXp) xp")
                        .font(.extraLargeTitle)
                        .contentTransition(.numericText())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
                .padding(.all, 50)

            Button("Exit", systemImage: "chevron.left", action: {dismiss()})
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.all, 40)
        
        // Update score
        .onAppear(){
            let baseReward: Int = 5
            let calculateXp = countCorrectAnswers * 20 + baseReward
            
            userXpScore+=calculateXp
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation{
                    gainedXp = calculateXp
                }
                
                withAnimation(.spring(duration: 3)){
                    gainedProgress = Double(gainedXp) / 65
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
    EndOfGameView(countCorrectAnswers: 3)
        .previewVariables()
}
