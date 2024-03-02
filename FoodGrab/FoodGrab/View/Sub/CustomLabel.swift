//
//  CustomLabel.swift
//  FoodGrab
//
//  Created by jayvee on 9/7/23.
//

import SwiftUI

struct CustomLabel: View {
    
    // MARK: - PROPERTIES
    
    var text: String = "Some Text"
    var weight: Font.Weight = .semibold
    
    var body: some View {
        Text(text)
            .font(.system(size: 15.0, weight: weight, design: .rounded))
    }
}

// MARK: - PREVIEW

struct CustomLabel_Previews: PreviewProvider {
    static var previews: some View {
        CustomLabel()
            .previewLayout(.fixed(width: 100.0, height: 100.0))
    }
}
