//
//  ChatComposer.swift
//  Dishcover
//
//  Created by j8bok on 6/9/24.
//

import SwiftUI

struct ChatComposer: View {
    
    // MARK: - PROPERTIES
    
    var screenSize: CGSize
    
    @State var test = ""

    @State private var didTapSend: Bool = false
    
    var body: some View {
        HStack(spacing: 20.0) {
            withAnimation(.easeInOut) {
                TextField(AppConstants.messagePlaceHolder, text: $test, axis: .vertical)
                    .lineLimit(...5)
            }
            
            Group {
                let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.customGreen)
                
                Image(systemName: AppConstants.paperPlaneCircelFill)
                    .configure(withModifier: imageModifier)
                    .rotationEffect(.degrees(45.0))
                    .frame(width: screenSize.width * 0.04, height: screenSize.height * 0.04)
                    .opacity(didTapSend ? 0 : 1)
                    .onTapGesture {
                        didTapSend = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                            withAnimation {
                                didTapSend = false
                            }
                        }
                    }
            }
        }//: HStack
        .padding(.horizontal, 20)
        .frame(width: screenSize.width * 0.9)
        .padding(.vertical, 15)
        .background(.customWhite)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: Color.black.opacity(0.1), radius: 5.0, x: 0.0, y: 5.0)
    }
}

#Preview {
    ChatComposer(screenSize: CGSize())
}
