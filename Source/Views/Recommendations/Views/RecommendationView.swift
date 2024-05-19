//
//  SwiftUIView.swift
//  Arcy
//
//  Created by Matt Novoselov on 09/05/24.
//

import SwiftUI

// View for displaying Artifacts that have been recommended to user by ML model based on his preferences
struct RecommendationView: View {
    
    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingRecommendationCompleted") private var onboardingRecommendationCompleted: Bool = false
    
    // Value that is reverse to onboardingRecommendationCompleted
    @State private var showingRecommendationOnboarding: Bool = true
    
    // Compiled and prepared for ML model dictionary that represents an array of Artifacts and their ratings (Liked or Not liked)
    var compiledModel: [Int64: Double]
    
    // Processed through ML model recommendations output
    var topRecommendations: Recommender
    
    // Check if any artifacts were marked as Liked
    // If none artifacts are right, the ML model can't make a good prediction
    @State private var noneArtifactsAreLiked: Bool
    
    // Load all artifacts from the collection
    let artifactCollection: [Artifact]
    
    // An array of Artifacts that should be displayed in the grid after processing of ML model recommendations output
    var gridToDisplay: [Artifact] = []
    
    init(compiledModel: [Int64 : Double], artifactCollection: [Artifact]) {
        self.artifactCollection = artifactCollection
        self.compiledModel = compiledModel
        self.topRecommendations = Recommender(compiledModel: compiledModel)
        
        // Check if all Artifacts in compiledModel are Liked
        noneArtifactsAreLiked = compiledModel.values.allSatisfy { $0 == 0 }
        
        // Prepare the grid of recommendations to display after processing the output of the ML Model
        gridToDisplay = artifactCollection.filter { artifact in
            topRecommendations.artifacts.contains(where: { $0.ArtifactId == artifact.artifactID })
        }
    }
    
    var body: some View {
        
        ZStack{
            // Display ContentUnavailableView if there are no recommendations
            if noneArtifactsAreLiked{
                ContentUnavailableView("No recommendations", systemImage: "sparkle.magnifyingglass", description: Text("Try liking a few artifacts to see recommendations."))
            } else{
                // Or display grid with AI recommendations
                GridView(gridToDisplay: gridToDisplay, showingLikes: false, showingSparkles: true)
            }
        }
        
        // Present onboarding sheet that explains the purpose of onboarding
        .sheet(isPresented: $showingRecommendationOnboarding) {
            OnboardingRecommendationView()
        }
        
        // Control showingRecommendationOnboarding value
        .onAppear{
            showingRecommendationOnboarding = !onboardingRecommendationCompleted
        }
        .onChange(of: onboardingRecommendationCompleted){
            showingRecommendationOnboarding = !onboardingRecommendationCompleted
        }
        
        // Toolbar
        .toolbar{
            // Header text
            ToolbarItem(placement: .topBarTrailing){
                Label("Suggested by AI", systemImage: "sparkles")
                    .labelStyle(CenteredLabelStyle())
                    .font(.title)
                    .foregroundStyle(.tertiary)
                    .padding()
            }

        }
        
    }
}
