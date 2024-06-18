//
//  ButtonOne.swift
//  Dishcover
//
//  Created by j8bok on 8/30/23.
//

import SwiftUI

struct ButtonOne: View {
    
    // MARK: - PROPERTIES
    
    var attribute: ButtonOneAttributes
    var fontWeight: Font.Weight
    
    var body: some View {
        let textModifier = [TextModifier(font: .system(size: attribute.fontSize, weight: fontWeight, design: .rounded), color: attribute.fontColor)]
        
        RoundedRectangle(cornerRadius: attribute.cornerRadius)
            .foregroundColor(Color(attribute.bgColor))
            .overlay(
                Text(attribute.text)
                    .configure(withModifier: textModifier)
            )
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview(traits: .fixedLayout(width: 345.0, height: 50.0)) {
//    ButtonOne(attribute: ButtonOneAttributes())
//}
