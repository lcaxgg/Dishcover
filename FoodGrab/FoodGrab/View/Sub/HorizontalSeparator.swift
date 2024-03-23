//
//  HorizontalSeparator.swift
//  FoodGrab
//
//  Created by j8bok on 9/7/23.
//

import SwiftUI

struct HorizontalSeparator: View {
    
    // MARK: - PROPERTIES
    
    var color: String = AppConstants.lightGrayThree
    var height: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Color(color)
                .frame(height: height)
        }
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview(traits: .fixedLayout(width: 345.0, height: 20.0)) {
//    HorizontalSeparator()
//}

