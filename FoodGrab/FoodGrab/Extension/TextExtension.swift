//
//  TextExtension.swift
//  FoodGrab
//
//  Created by jayvee on 10/13/23.
//

import Foundation
import SwiftUI

extension Text {
    func configure(withModifier modifier: [TextModifier]) -> some View {
        modifier.reduce(self) { (txt, mod) in
            mod.modifyText(txt)
        }
    }
}
