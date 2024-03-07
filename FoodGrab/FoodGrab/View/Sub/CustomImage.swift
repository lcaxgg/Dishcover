//
//  CustomImage.swift
//  FoodGrab
//
//  Created by j8bok on 9/7/23.
//

import SwiftUI

struct CustomImage: View {
    
    // MARK: - PROPERTIES
    
    var imageName: String = AppConstants.photoCircle
    var color: String = AppConstants.lightGrayTwo
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundColor(Color(color))
    }
}

// MARK: - PREVIEW

#Preview {
    CustomImage()
        .previewLayout(.fixed(width: 100.0, height: 100.0))
}
