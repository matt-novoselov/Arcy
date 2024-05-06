//
//  ExpandableMapView.swift
//  Arcy
//
//  Created by Matt Novoselov on 05/05/24.
//

import SwiftUI
import MapKit

struct ExpandableMapView: View {
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            Button(action: {switchState()}){
                Map()
                    .mapStyle(.imagery)
                    .scaledToFill()
            }
            .buttonBorderShape(.roundedRectangle(radius: 20))
            .frame(maxWidth: isExpanded ? .infinity : 400, maxHeight: isExpanded ? .infinity : 400)
            
            if isExpanded{
                Button(action: {switchState()}){
                    Label("Collapse", systemImage: "arrow.up.right.and.arrow.down.left")
                }
                .padding()
            }
            
        }
        .cornerRadius(20)
        
    }
    
    func switchState(){
        withAnimation{
            isExpanded.toggle()
        }
    }
}
#Preview {
    ExpandableMapView()
}
