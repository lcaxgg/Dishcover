//
//  SwiftUIView.swift
//  FoodGrab
//
//  Created by jayvee on 9/7/23.
//

import SwiftUI

struct CustomPreview<Content: View>: View {
    var someView: () -> Content
        
        init(@ViewBuilder content: @escaping () -> Content) {
            someView = content
        }
    
    var body: some View {
        Group {
//            someView()
//                .previewDevice("iPod touch (7th generation)")

//            someView()
//                .previewDevice("iPhone SE (2nd generation)")

            someView()
                .previewDevice("iPhone 15 Pro Max")
//
//            someView()
//                .previewDevice("iPad Air (5th generation)")

//            someView()
//                .previewDevice("iPad Pro (9.7-inch)")
        }
    }
}
