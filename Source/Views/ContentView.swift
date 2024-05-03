//
//  ContentView.swift
//  Arcy
//
//  Created by Matt Novoselov on 20/04/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false
    
    @Environment(\.modelContext) var modelContext
    @State private var settings: ProfileData?
    
    @State var animatedOnboardingCompleted: Bool = false


    var body: some View {
        
        Group{
            if let settings{
            
                Group{
                    if animatedOnboardingCompleted{
                        ArchiveView(settings: settings)
                            .transition(.blurReplace)
                    } else{
                        OnboardingView(settings: settings)
                            .transition(.blurReplace)
                    }
                }
                .environment(settings)
                .onAppear(){
                    animatedOnboardingCompleted = onboardingCompleted
                }
                .onChange(of: onboardingCompleted){
                    withAnimation{
                        animatedOnboardingCompleted = onboardingCompleted
                    }
                }

            } else{
                ProgressView()
            }
        }
        .onAppear(perform: load)
    
    }
    
    func load() {
        let request = FetchDescriptor<ProfileData>()
        let data = try? modelContext.fetch(request)
        settings = data?.first ?? ProfileData(userName: "")
    }
    
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .modelContainer(for: ProfileData.self)
}
