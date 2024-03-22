//
//  ScreenSizeReader.swift
//  FoodGrab
//
//  Created by j8bok on 3/18/24.
//

import SwiftUI

struct ScreenSizeReader<Content: View>: View {
    let content: (CGSize) -> Content

    var body: some View {
        GeometryReader { geometry in
            self.content(geometry.size)
        }
    }
}

@available(iOS 17, *)
#Preview {
    ScreenSizeReader { size in
        Color.green
            .frame(width: size.width / 2, height: size.height / 2)
    }
}
