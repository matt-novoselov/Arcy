//
//  ShadowGuessView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ShadowGuessView: View {
    
    let hiddenModelName: String
    let hiddenName: String
    
    @State var variantsArray: [String]
    
    let variantsArrayHinted: [String]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var selectedAnswer: String?
    
    init(){
        let modelLibrary: [Artifact] = Collection().artifacts
        
        guard let randomArcheologicalItem = modelLibrary.randomElement() else {
            fatalError("Model library is empty.")
        }
        
        self.hiddenModelName = randomArcheologicalItem.modelName
        self.hiddenName = randomArcheologicalItem.name
        
        var randomModels: Set<String> = [randomArcheologicalItem.name]
        
        while randomModels.count < 4 {
            if let randomModel = modelLibrary.randomElement()?.name {
                randomModels.insert(randomModel)
            }
        }
        
        var randomModelsHinted: Set<String> = [randomArcheologicalItem.name]
        
        while randomModelsHinted.count < 2 {
            if let randomModelHinted = randomModels.randomElement() {
                randomModelsHinted.insert(randomModelHinted)
            }
        }
        
        self.variantsArrayHinted = Array(randomModelsHinted)
        self.variantsArray = Array(randomModels).shuffled()
    }
    
    var body: some View {
        
        VStack{
            if variantsArray != variantsArrayHinted && selectedAnswer == nil{
                Button(action: {getHint()}){
                    Label("Get hint", systemImage: "lightbulb.max")
                        .labelStyle(CenteredLabelStyle())
                }
            }
            
            Spacer()
            
            ArtifactModelView(modelName: hiddenModelName)
            
            Spacer()
            
            LazyVGrid(columns: columns) {
                ForEach(variantsArray, id: \.self) { item in
                    Button(action: {
                        withAnimation{
                            selectedAnswer=item
                        }
                    }, label: {
                        Text(item)
                            .font(.title)
                            .padding()
                            .frame(maxWidth: .infinity)
                    })
                    .disabled(selectedAnswer != nil)
                    
                    // Highlight correct answer
                    .background(selectedAnswer != nil && item == hiddenName ? Color.green : Color.clear)
                    
                    // Highlight incorrect answer
                    .background(selectedAnswer != nil && item == selectedAnswer ? Color.red : Color.clear)
                    
                    .clipShape(.capsule)
                    
                    // Highlight correct and incorrect answers
                    .overlay{
                        if (selectedAnswer != nil && item == hiddenName || item == selectedAnswer){
                            Text(item)
                                .font(.title)
                        }
                    }
                
                }
            }
        
        }
        .padding()
        .navigationTitle("Guess the name of the exhibit based on the silhouette.")

        .overlay{
            if selectedAnswer == hiddenName{
                Model3D(named: "Fireworks", bundle: realityKitContentBundle)
            }
        }
        
        .onChange(of: selectedAnswer){
            print(hiddenName == selectedAnswer)
        }
        
    }
    
    func getHint(){
        withAnimation{
            variantsArray = variantsArrayHinted
        }
    }
}

#Preview(windowStyle: .automatic) {
    ShadowGuessView()
}
