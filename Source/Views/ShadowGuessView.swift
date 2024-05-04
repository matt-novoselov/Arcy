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
    
    @State var variantsArray: [String]
    
    let variantsArrayHinted: [String]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(){
        let modelLibrary: [Artifact] = Collection().artifacts
        
        guard let randomArcheologicalItem = modelLibrary.randomElement() else {
            fatalError("Model library is empty.")
        }
        
        self.hiddenModelName = randomArcheologicalItem.modelName
        
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
        
        self.variantsArrayHinted = Array(randomModelsHinted).shuffled()
        self.variantsArray = Array(randomModels).shuffled()
    }
    
    var body: some View {
        
        VStack{
            Text("Guess the name of the exhibit based on the silhouette.")
                .font(.largeTitle)
            
            ArtifactModelView(modelName: hiddenModelName)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(variantsArray, id: \.self) { item in
                    Button(action: {}, label: {
                        Text(item)
                    })
                    .buttonBorderShape(.roundedRectangle)
                }
            }
            
            if variantsArray != variantsArrayHinted{
                Button(action: {getHint()}){
                    Label("Get hint", systemImage: "lightbulb.max")
                        .labelStyle(CenteredLabelStyle())
                }
            }
        }
        .overlay{
            Model3D(named: "Fireworks", bundle: realityKitContentBundle)
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
