//
//  ImageExtension.swift
//  FoodGrab
//
//  Created by j8bok on 10/13/23.
//

import Foundation
import SwiftUI

extension Image {
    func configure(withModifier modifier: ImageModifier) -> some View {
        modifier.modifyImage(self)
    }
}
