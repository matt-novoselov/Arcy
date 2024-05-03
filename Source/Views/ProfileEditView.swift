//
//  ProfileEditView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI
import PhotosUI

struct ProfileEditView: View {
    
    @Binding var textInput: String
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var showingPhotoPicker: Bool = false
    
    var settings: ProfileData
    
    var body: some View {
        
        // Button to trigger the photo picker
        Button(action: { showingPhotoPicker = true }) {
            ProfilePictureView(settings: settings)
        }
        .buttonBorderShape(.circle)
        .frame(width: 300)
        
        
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
            
            Task{
                guard let imageData = try await avatarItem?.loadTransferable(type: Data.self) else { return }
                print(imageData.self)
                settings.myImage640 = imageData
            }
        }
        
        TextField("Your name", text: $textInput.animation())
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            .onChange(of: textInput){
                settings.userName = textInput
            }
    }
    
}

#Preview(windowStyle: .automatic) {
    ProfileEditView(textInput: .constant(""), settings: ProfileData(userName: ""))
}
