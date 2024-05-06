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
    
    // Get user score value from the user defaults
    @AppStorage("userXpScore") private var userXpScore: Int = 0
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack{
            Text("Hello, World!")
                .font(.title)
            
            Text("+\(gainedXp)XP")
                .font(.extraLargeTitle)
                .contentTransition(.numericText())
            
            Spacer()
            
            Button("Exit", systemImage: "chevron.left", action: {dismiss()})
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        
        // Display confetti on correct answer
        .overlay{
            Model3D(named: "Fireworks", bundle: realityKitContentBundle)
        }
        
        // Update score
        .onAppear(){
            let calculateXp = countCorrectAnswers * 15
            
            userXpScore+=calculateXp
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation{
                    gainedXp = calculateXp
                }
            }
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    EndOfGameView(countCorrectAnswers: 3)
}
