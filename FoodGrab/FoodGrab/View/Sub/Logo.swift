//
//  Logo.swift
//  FoodGrab
//
//  Created by jayvee on 8/30/23.
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

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(AppConstants.green)
                .ignoresSafeArea(.all)
            
            Logo()
        }
        .previewLayout(.fixed(width: 100.0, height: 100.0))
    }
}

