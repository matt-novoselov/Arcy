//
//  ShadowGuessView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct ShadowGuessView: View {
    
    let hiddenModelName: String
    
    let data: [String]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(){
        let modelLibrary: [ArcheologicalItem] = ArcheologicalItemsCollection().items
        
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
        
        self.data = Array(randomModels).shuffled()
    }
    
    var body: some View {
        
        VStack{
            Text("Guess the name of the exhibit based on the silhouette.")
                .font(.largeTitle)
            
            ModelView(modelName: hiddenModelName)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { item in
                    Button(action: {}, label: {
                        Text(item)
                    })
                    .buttonBorderShape(.roundedRectangle)
                }
            }
        }
        
    }
}

#Preview(windowStyle: .automatic) {
    ShadowGuessView()
}
