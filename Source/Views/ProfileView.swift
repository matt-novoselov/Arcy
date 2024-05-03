//
//  ProfileView.swift
//  Ancient Archive
//
//  Created by Matt Novoselov on 02/05/24.
//

import SwiftUI

struct ProfileView: View {
    
    // Get onboarding complete value from the user defaults
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false
    
    var body: some View {
        VStack{
            Text("Profile view")
            
            Text("Name")
            
            Text("Edit name")
            
            Text("Photo")
            
            Text("Edit photo")
            
            Button(action: {onboardingCompleted = false}, label: {
                Text("Reset onboarding")
            })
        }
    }
}

#Preview(windowStyle: .automatic) {
    ProfileView()
}
