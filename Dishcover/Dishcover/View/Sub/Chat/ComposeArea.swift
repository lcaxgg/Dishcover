//
//  ComposeArea.swift
//  Dishcover
//
//  Created by j8bok on 6/9/24.
//

import SwiftUI

struct ComposeArea: View {
    
    // MARK: - PROPERTIES
    
    var screenSize: CGSize
    
    @State var test = ""
    @State private var isKeyboardShowing: Bool = false
    @State private var keyboardHeight: CGFloat = 0.0
    
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
        .ignoresSafeArea(.keyboard)
        .padding(.horizontal, 20)
        .frame(width: screenSize.width * 0.9)
        .padding(.vertical, 15)
        .background(.customWhite)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: Color.black.opacity(0.1), radius: 5.0, x: 0.0, y: 5.0)
        .padding(.bottom, isKeyboardShowing ? keyboardHeight : screenSize.height * 0.06)
        .animation(.easeInOut, value: isKeyboardShowing)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
            isKeyboardShowing = true
            
            if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                keyboardHeight = keyboardSize.height + 10.0
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
            isKeyboardShowing = false
            keyboardHeight = 0.0
        }
    }
}

#Preview {
    ComposeArea(screenSize: CGSize())
}
