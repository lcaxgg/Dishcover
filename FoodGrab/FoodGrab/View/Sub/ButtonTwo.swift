//
//  ButtonTwo.swift
//  FoodGrab
//
//  Created by j8bok on 9/20/23.
//

import SwiftUI

struct ButtonTwo: View {
    
    // MARK: - PROPERTIES
    
    var text: String = AppConstants.register
    var isEnabled: Bool = true
    var action: () -> Void
    
    var attribute: ButtonOneAttributes
    
    var body: some View {
        ButtonOne(attribute: attribute)
            .onTapGesture {
                if isEnabled {
                    action()
                }
            }
    }
}

// MARK: - PREVIEW

struct CustomButtonTwo_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTwo(action: {}, attribute: ButtonOneAttributes())
            .previewLayout(.fixed(width: 345.0, height: 50.0))
    }
}
