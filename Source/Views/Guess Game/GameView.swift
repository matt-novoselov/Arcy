//
//  GameView.swift
//  Arcy
//
//  Created by Matt Novoselov on 06/05/24.
//

import SwiftUI

struct GameView: View {
    
    @State private var currentLevel: Int = 0
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        @State var currentProgress: Double = Double(currentLevel)/3
        
        VStack{
            HStack{
                Button(action: {dismiss()}){
                    Image(systemName: "chevron.left")
                }
                .buttonBorderShape(.circle)
                .help("Back")
                
                Button(action: {}){
                    Image(systemName: "chevron.left")
                        .frame(maxWidth: .infinity)
                }
                .tint(.clear)
                .foregroundStyle(.clear)
                .allowsHitTesting(false)
                .overlay{
                    ProgressBar(progress: $currentProgress)
                        .padding()
                }
            }
            .padding(.all, 10)
            .toolbar(.hidden)
            
            Group{
                switch currentLevel {
                case 0:
                    GuessGameView()
                case 1:
                    GuessGameView()
                case 2:
                    GuessGameView()
                    
                default:
                    FavoritesView()
                }
            }
            .frame(maxWidth: .infinity)
            .transition(.pushLeftTransition)
            
            Button("Next"){
                nextLevel()
            }
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
}
