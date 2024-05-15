//
//  ShadowGuessView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

// Guess artifacts view shows a random artifact and suggests users 4 options to try to guess the name
struct GuessArtifactView: View {
    
    // Artifact that users needs to guess
    private let hiddenArtifact: Artifact
    
    // Array of 4 of suggested artifacts names
    // One of the names is the name of hiddenArtifact
    @State private var artifactVariantsNames: [String]
    
    // Array of 2 of suggested artifacts names
    // One of the names is the name of hiddenArtifact
    private let artifactVariantsNamesHinted: [String]
    
    // Columns for lazy stack
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // Property that stores the name of the answer that user selected
    @State private var selectedAnswer: String?
    
    // Pass action that should be executed, when clicking on the next button
    var nextButtonAction: () -> Void
    
    // Binding that counts how many times the user guessed the artifacts correctly
    @Binding var countCorrectAnswers: Int
    
    // Initializer
    init(nextButtonAction: @escaping () -> Void, countCorrectAnswers: Binding<Int>) {
        // Assign binding
        _countCorrectAnswers = countCorrectAnswers
        
        // Assign button action
        self.nextButtonAction = nextButtonAction
        
        // Load all artifacts from the library
        let artifactsCollection: [Artifact] = ArtifactsCollection().artifacts
        
        // Select a random artifact from library
        guard let randomArtifact = artifactsCollection.randomElement() else {
            fatalError("Model library is empty.")
        }
        self.hiddenArtifact = randomArtifact
        
        // A set of unique names for artifact variants
        // Should always contain 4 artifacts, one of which is correct
        var randomArtifactNames: Set<String> = [randomArtifact.name]
        
        // Fill variants array with unique names
        while randomArtifactNames.count < 4 {
            if let randomArtifactName = artifactsCollection.randomElement()?.name {
                randomArtifactNames.insert(randomArtifactName)
            }
        }
        
        // A set of unique names for hinted artifact variants
        // Should always contain 2 artifacts, one of which is correct
        var randomArtifactNamesHinted: Set<String> = [randomArtifact.name]
        
        // Fill hinted variants array with names from randomArtifactNames
        while randomArtifactNamesHinted.count < 2 {
            if let randomArtifactHinted = randomArtifactNames.randomElement() {
                randomArtifactNamesHinted.insert(randomArtifactHinted)
            }
        }
        
        // Assign pre made arrays
        self.artifactVariantsNamesHinted = Array(randomArtifactNamesHinted)
        self.artifactVariantsNames = Array(randomArtifactNames).shuffled()
    }
    
    // Hold lazy grid as a separate view to fix SwiftUI bug
    private var lazyGridContent: some View {
        // Display variants as buttons
        LazyVGrid(columns: columns) {
            ForEach(artifactVariantsNames, id: \.self) { singleArtifact in
                GuessGameButton(singleArtifact: singleArtifact, hiddenArtifact: hiddenArtifact, selectedAnswer: $selectedAnswer, countCorrectAnswers: $countCorrectAnswers)
            }
        }
        .padding(.all, 20)
     }
    
    var body: some View {
        
        VStack{
            // Title
            Text("Guess the name of the artifact")
                .font(.title)
            
            Spacer()
            
            // Hidden artifact model, that can be rotated on y axis
            ArtifactModelView(modelName: hiddenArtifact.modelName, allowYawRotation: true)
            
            Spacer()

            // Wrap in scroll view to fix animation transition
            // Note: Structure should be simplified, if the bug will be fixed in the future versions of SwiftUI for VisionOS
            lazyGridContent
                .hidden()
                .overlay {
                    ScrollView { lazyGridContent }
                        .scrollDisabled(true)
                }
            
        }
        .padding()

        // Ornament
        .toolbar{
            // Get hint button
            ToolbarItem(placement: .bottomOrnament){
                Button(action: {getHint()}){
                    Label("Get hint", systemImage: "lightbulb.max")
                        .labelStyle(CenteredLabelStyle())
                }
                // Disabled if hint was already requested or if the answer was already given
                .disabled(artifactVariantsNames == artifactVariantsNamesHinted || selectedAnswer != nil)
            }
            
            // Next level button
            ToolbarItem(placement: .bottomOrnament){
                Button(action: {nextButtonAction()}){
                    Label("Next", systemImage: "arrow.right")
                }
                // Disabled until the answer is given
                .disabled(selectedAnswer == nil)
            }
        }
        
    }
    
    // Function to eliminate half of the possible variants
    func getHint(){
        withAnimation{
            artifactVariantsNames = artifactVariantsNamesHinted
        }
    }
}

#Preview(windowStyle: .automatic) {
    GuessArtifactView(nextButtonAction: {}, countCorrectAnswers: .constant(0))
        .previewVariables()
}
