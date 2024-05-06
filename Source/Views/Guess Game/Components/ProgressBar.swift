import SwiftUI

// Level progress bar is visible on the top of the level view and determines current progress of the user
struct ProgressBar: View {
    
    // Store the size of the view
    @State private var size: CGSize = .zero
    
    // Progress is the value from 0 to 1
    var progress: Double
    
    var body: some View {
        
        ZStack (alignment: .leading){
            // Underlying gray line
            RoundedRectangle(cornerRadius: .infinity)
                .foregroundStyle(.regularMaterial)
            
            // Main progress indicator
            RoundedRectangle(cornerRadius: .infinity)
                .foregroundStyle(.fill.secondary)
                .frame(width: CGFloat(size.width) * CGFloat(progress==0 ? 0.1 : progress))
        }
        
        // Determine frame size using GeometryReader
        .background{
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        size = proxy.size
                    }
            }
        }
        
    }
}
