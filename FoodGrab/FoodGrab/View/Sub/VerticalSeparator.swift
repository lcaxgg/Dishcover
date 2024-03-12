//
//  VerticalSeparator.swift
//  FoodGrab
//
//  Created by j8bok on 9/7/23.
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

@available(iOS 17, *)
#Preview(traits: .fixedLayout(width: 1.0, height: 100.0)) {
    VerticalSeparator()
}
