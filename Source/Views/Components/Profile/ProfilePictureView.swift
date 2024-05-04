//
//  ProfilePictureView.swift
//  Arcy
//
//  Created by Matt Novoselov on 03/05/24.
//

import SwiftUI

struct ProfilePictureView: View {
    
    var body: some View {
        
        EmptyView()
        
//        Group{
//            // Using UIImage to create an image from Data
//            if let profileImage = settings.myImage640, let uiImage = UIImage(data: profileImage) {
//                // Using Image view to display the UIImage
//                Image(uiImage: uiImage)
//                    .resizable()
//
//            } else {
//                GeometryReader{ proxy in
//                    Image(systemName: "person.crop.circle.fill")
//                        .resizable()
//                        .shadow(radius: 10)
//                        .background(.gray)
//                        .overlay(
//                            Circle()
//                                .stroke(Color.white, lineWidth: proxy.size.width/10)
//                        )
//                }
//            }
//        }
//        .clipShape(.circle)
//        .scaledToFit()
        
    }
}

#Preview(windowStyle: .automatic) {
    ProfilePictureView()
}
