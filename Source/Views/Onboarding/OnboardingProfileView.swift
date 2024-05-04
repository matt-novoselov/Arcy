//
//  OnboardingProfileView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI


struct OnboardingProfileView: View {
    
    @State private var textInput: String = ""
    @Binding var onboardingState: onboardingState

    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false
    
    var body: some View {
        
        NavigationStack{
            VStack(spacing: 20){
                
                Text("Let's setup your profile")
                    .font(.title)
                
                ProfileEditView(textInput: $textInput)
                
                Button(action: {
                    onboardingCompleted = true
                }, label: {
                    Text(textInput.isEmpty ? "Enter name to continue" : "Continue")
                        .clipped()
                })
                .disabled(textInput.isEmpty)

            }
        }
        .onAppear{
            // Load name to textfield from saved data
        }

    }
}

#Preview(windowStyle: .automatic) {
    OnboardingProfileView(onboardingState: .constant(.profile))
}





extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}

extension String {
    var imageFromBase64: UIImage? {
        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return UIImage(data: imageData)
    }
}
