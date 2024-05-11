//
//  GameView.swift
//  Arcy
//
//  Created by Matt Novoselov on 06/05/24.
//

import SwiftUI

struct GameView: View {
    
    @State private var currentLevel: Int = 0
    @State private var countCorrectAnswers: Int = 0
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack{
            // Custom toolbar visible during game phase
            if currentLevel < 3{
                HStack{
                    Button(action: {dismiss()}){
                        Image(systemName: "chevron.left")
                    }
                    .buttonBorderShape(.circle)
                    .help("Back")
                    
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
            
            Group{
                switch currentLevel {
                case 0:
                    GuessGameView(nextButtonAction: {nextLevel()}, countCorrectAnswers: $countCorrectAnswers)
                case 1:
                    GuessGameView(nextButtonAction: {nextLevel()}, countCorrectAnswers: $countCorrectAnswers)
                case 2:
                    GuessGameView(nextButtonAction: {nextLevel()}, countCorrectAnswers: $countCorrectAnswers)
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
