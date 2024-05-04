//
//  ImageModifier.swift
//  Dishcover
//
//  Created by j8bok on 10/13/23.
//

import Foundation
import SwiftUI

struct ImageModifier {
    //var aspectRatio: CGFloat
    var contentMode: ContentMode
    var color: String
  
    func modifyImage(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: contentMode)
            //.aspectRatio(aspectRatio, contentMode: contentMode)
            .foregroundColor(Color(color))
    }
}
