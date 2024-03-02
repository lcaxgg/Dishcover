//
//  VerticalSeparator.swift
//  FoodGrab
//
//  Created by jayvee on 9/7/23.
//

import SwiftUI

struct VerticalSeparator: View {
    
    // MARK: - PROPERTIES
   
    var body: some View {
        ZStack {
            Color(AppConstants.lightGrayThree)
                .frame(width: 1.0)
        }
    }
}

// MARK: - PREVIEW

struct VerticalSeparator_Previews: PreviewProvider {
    static var previews: some View {
        VerticalSeparator()
            .previewLayout(.fixed(width: 1.0, height: 100.0))
    }
}
