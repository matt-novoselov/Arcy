//
//  ProfileView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var textInput: String = ""
    
    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false
    
    @State var showAlert: Bool = false
    
    var settings: ProfileData
    
    var body: some View {
        VStack{
            ProfileEditView(textInput: $textInput, settings: settings)
            
            Button(action: {showAlert = true}, label: {
                Text("Reset onboarding")
            })
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Are you sure you want to reset onboarding?"),
                message: Text("This action cannot be undone."),
                primaryButton: .destructive(Text("Reset")) {
                    onboardingCompleted = false
                },
                secondaryButton: .cancel()
            )
        }
    }
}

#Preview(windowStyle: .automatic) {
    ProfileView(settings: ProfileData(userName: ""))
}
