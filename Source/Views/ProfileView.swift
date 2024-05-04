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
    
    var body: some View {
        VStack{
            
            Spacer()
            
            ProfileEditView(textInput: $textInput)
            
            Button(action: {showAlert = true}, label: {
                Text("Reset onboarding")
            })
            
            Spacer()
            
            HStack(spacing: 5){
                Text("Developed with")
                
                OneShotLikeButtonView()
                
                Text("by Matt Novoselov")
            }
            .font(.caption)
            .opacity(0.5)
        }
        .padding()
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
    ProfileView()
}
