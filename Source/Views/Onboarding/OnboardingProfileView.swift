//
//  OnboardingProfileView.swift
//  Ancient Archive
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI
import PhotosUI

struct OnboardingProfileView: View {
    
    @State private var textInput: String = ""
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var showingPhotoPicker: Bool = false
    @Binding var onboardingState: onboardingState
    
    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false
    
    var body: some View {
        
        NavigationStack{
            VStack(spacing: 20){
                
                Text("Let's setup your profile")
                    .font(.title)
                
                // Button to trigger the photo picker
                Button(action: { showingPhotoPicker = true }) {
                    if let avatarImage{
                        avatarImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else{
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .buttonBorderShape(.circle)
                .frame(width: 300)
                .shadow(color: .white, radius: 10)
                
                // Integrates the PhotosPicker with the SwiftUI view hierarchy
                .photosPicker(isPresented: $showingPhotoPicker, selection: $avatarItem, matching: .images)
                
                // Load the selected image
                .onChange(of: avatarItem) {
                    Task {
                        if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                            avatarImage = loaded
                        } else {
                            print("Failed")
                        }
                    }
                }
                
                TextField("Your name", text: $textInput)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    onboardingCompleted = true
                }, label: {
                    Text("Continue")
                })
                .disabled(textInput.isEmpty)
                
            }

        }

    }
}

#Preview(windowStyle: .automatic) {
    OnboardingProfileView(onboardingState: .constant(.profile))
}
