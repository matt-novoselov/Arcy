//
//  ProfileEditView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI
import PhotosUI

struct ProfileEditView: View {
    
    @State var textInput: String = UserDefaults.standard.string(forKey: "userName") ?? ""
    @State private var avatarItem: PhotosPickerItem?
    @State private var showingPhotoPicker: Bool = false
    
    @State var showingShimmer: Bool = false
    
    @State var shimmerStartTime = Date.now
    
    var body: some View {
        
        // Button to trigger the photo picker
        Button(action: { showingPhotoPicker = true }) {
            ProfilePictureView(startTime: shimmerStartTime, showingShimmer: showingShimmer)
        }
        .buttonBorderShape(.circle)
        .frame(width: 300)
        
        // Integrates the PhotosPicker with the SwiftUI view hierarchy
        .photosPicker(isPresented: $showingPhotoPicker, selection: $avatarItem, matching: .images)
        
        // Load the selected image
        .onChange(of: avatarItem) {
            // MARK: Save image to persistence
            
            showingShimmer = true
            shimmerStartTime = Date.now
        }

        TextField("Your name", text: $textInput.animation())
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            .onChange(of: textInput){
                UserDefaults.standard.set(textInput, forKey: "userName")
            }
    }
    
}

#Preview(windowStyle: .automatic) {
    ProfileEditView(showingShimmer: true)
}
