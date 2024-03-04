//
//  TextModifier.swift
//  FoodGrab
//
//  Created by j8bok on 10/13/23.
//

import Foundation
import SwiftUI

struct TextModifier {
    var font: Font
    var color: String
    
    func modifyText(_ text: Text) -> Text {
        text
            .font(font)
            .foregroundColor(Color(color))
    }
}


