//
//  ScreenSizeReader.swift
//  Dishcover
//
//  Created by j8bok on 3/18/24.
//

import SwiftUI

struct ScreenSizeReader<Content: View>: View {
    
    // MARK: - PROPERTIES
    
    let content: (CGSize) -> Content

    var body: some View {
        GeometryReader { geometry in
            self.content(geometry.size)
        }
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview {
//    ScreenSizeReader { size in
//        Color.green
//            .frame(width: size.width / 2, height: size.height / 2)
//    }
//}
