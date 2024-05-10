//
//  SwiftUIView.swift
//  Arcy
//
//  Created by Matt Novoselov on 09/05/24.
//

import SwiftUI
import Combine
import CoreML
import SwiftData

// RecommendationProxyView is a link between RecommendationView and SwiftData
// this View is supposed to get stored in SwiftData likeModel
struct RecommendationProxyView: View {
    
    // Get stored artifacts with likes from SwiftData model
    @Query var storedLikedArtifacts: [LikeModel]
    
    
    // Load all artifacts from the collection
    let artifactCollection: [Artifact]
    
    // Display main RecommendationView
    var body: some View {
        RecommendationView(compiledModel: compileModel(), artifactCollection: artifactCollection)
    }
    
    //
    // Compile a data model that will be passed to the ML model for analyzation
    // Go through each stored liked artifact
    // and transform it to the format of dictionary
    // where: [ArtifactID : isLiked]
    // isLiked = true = 1
    // isLiked = false = 0
    //
    // The ratings are need to be given in Double value that is between 0 and 1,
    // so the model can correctly represent the data
    //
    // example: [12 : 1]
    // 12 is an ID of an Artifact and 1 represents that this artifact has been liked
    //
    
    func compileModel() -> [Int64: Double] {
        var compiledModel: [Int64: Double] = [:]
        
        for artifact in storedLikedArtifacts {
            let ratingValue = artifact.isLiked ? 1.0 : 0.0
            compiledModel[Int64(artifact.artifactID)] = ratingValue
        }
        
        return compiledModel
    }
}

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
                GridView(gridToDisplay: gridToDisplay, showingLikes: false)
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
        
    }
}

struct ArtifactRecommendation: Identifiable {
    public var id = UUID()
    public var ArtifactId: Int
    public var isLiked: Double
    // isLiked = 0.0 = false
    // isLiked = 1.0 = true
    // Double representation is in need for ML Model to process recommendations
}

// The Recommender class is where the recommender model makes predictions based on user inputs.
// The following class is responsible for running the model predictions and updating them in the SwiftUI Views
@Observable public class Recommender {
    
    // A list of artifacts that has been recommended by AI model
    var artifacts = [ArtifactRecommendation]()
    
    // Compiled data model that will be passed to the ML model for analyzation
    var compiledModel: [Int64: Double] = [:]
    
    // Initializer
    init(compiledModel: [Int64 : Double]) {
        self.compiledModel = compiledModel
        load()
    }
    
    // The number of similar items to be returned by the model output.
    let amountOfResults: Int64 = 6
    
    func load() {
        do{
            // Initialize the ArcyRecommender with configuration
            let recommender = try ArcyRecommender(configuration: MLModelConfiguration())
            
            // ArcyRecommenderInput - auto-generated class from the Core ML model.
            //User input is passed here, which is a dictionary of item-rating pairs.
            //
            // In the restrict argument, the items that should be excluded from the recommendation output are passed.
            let input = ArcyRecommenderInput(items: compiledModel, k: amountOfResults, restrict_: [], exclude: [])
            
            // The result returned from the recommender model consists of item recommendations and scores, which indicate how similar the recommended artifacts were to the artifacts liked by the user.
            let result = try recommender.prediction(input: input)
            var tempArtifacts = [ArtifactRecommendation]()
            
            for str in result.recommendations{
                let score = result.scores[str] ?? 0
                tempArtifacts.append(ArtifactRecommendation(ArtifactId: Int(str), isLiked: score))
            }
            self.artifacts = tempArtifacts
            
        } catch(let error){
            print("error is \(error.localizedDescription)")
        }
    }
    
}
