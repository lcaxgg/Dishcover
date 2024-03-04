//
//  ButtonOne.swift
//  FoodGrab
//
//  Created by j8bok on 8/30/23.
//

import SwiftUI

struct ButtonOne: View {
    
    // MARK: - PROPERTIES
    
    var attribute: ButtonOneAttributes
    
    var body: some View {
        let textModifier = [TextModifier(font: .system(size: attribute.fontSize, weight: attribute.fontWeight, design: .rounded), color: attribute.fontColor)]
        
        RoundedRectangle(cornerRadius: attribute.cornerRadius)
            .foregroundColor(Color(attribute.bgColor))
            .overlay(
                Text(attribute.text)
                    .configure(withModifier: textModifier)
            )
    }
}

// MARK: - PREVIEW

struct CustomButtonOne_Previews: PreviewProvider {
    static var previews: some View {
        ButtonOne(attribute: ButtonOneAttributes())
            .previewLayout(.fixed(width: 345.0, height: 50.0))
    }
}
