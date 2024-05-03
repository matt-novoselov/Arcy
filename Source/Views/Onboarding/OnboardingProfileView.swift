//
//  OnboardingProfileView.swift
//  Arcy
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI
import SwiftData

struct OnboardingProfileView: View {
    
    @State private var textInput: String = ""
    @Binding var onboardingState: onboardingState
    
    @State var isTextFieldEmpty: Bool = true
    
    @Environment(\.modelContext) var modelContext
    var settings: ProfileData

    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false
    
    var body: some View {
        
        NavigationStack{
            VStack(spacing: 20){
                
                Text("Let's setup your profile")
                    .font(.title)
                
                ProfileEditView(textInput: $textInput, settings: settings)
                
                Button(action: {
                    onboardingCompleted = true
                }, label: {
                    Text(isTextFieldEmpty ? "Enter name to continue" : "Continue")
                        .clipped()
                })
                .disabled(isTextFieldEmpty)
                .onChange(of: textInput.isEmpty){
                    withAnimation{
                        isTextFieldEmpty = textInput.isEmpty
                    }
                }
                
            }

        }
        .onAppear(perform: load)

    }
    
    func load() {
        textInput = settings.userName
        isTextFieldEmpty = settings.userName.isEmpty
    }
}

#Preview(windowStyle: .automatic) {
    OnboardingProfileView(onboardingState: .constant(.profile), settings: ProfileData(userName: ""))
        .modelContainer(for: ProfileData.self)
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
