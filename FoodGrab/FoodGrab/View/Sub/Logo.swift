//
//  Logo.swift
//  FoodGrab
//
//  Created by j8bok on 8/30/23.
//

import SwiftUI

struct Logo: View {
    
    // MARK: - PROPERTIES
    
    var color: String = AppConstants.white
    
    var body: some View {
        ZStack {
            let imageModifier = ImageModifier(contentMode: .fit, color: color)
            
            Image(AppConstants.logo)
                .configure(withModifier: imageModifier)
        }
    }
}

// MARK: - PREVIEW

@available(iOS 17, *)
#Preview(traits: .fixedLayout(width: 100.0, height: 100.0)) {
    ZStack {
        Color(AppConstants.green)
            .ignoresSafeArea(.all)
        
        Logo()
    }
}
