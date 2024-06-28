//
//  ChatSelect.swift
//  Dishcover
//
//  Created by j8bok on 6/28/24.
//

import SwiftUI

struct ChatSelect: View {
    
    // MARK: - PROPERTIES
    
    var screenSize: CGSize
    @Binding var isPresentedChatSelect: Bool
    
    var body: some View {
        VStack {
            
            // MARK: - HEADER
            
            VStack {
                HStack {
                    let firstTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.022, weight: .regular, design: .rounded), color: AppConstants.customGreen)]
                    
                    Text(AppConstants.cancel)
                        .configure(withModifier: firstTextModifier)
                        .onTapGesture {
                            isPresentedChatSelect.toggle()
                        }
                    
                    Spacer()
                    
                    let secondTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.022, weight: .semibold, design: .rounded), color: AppConstants.customBlack)]
                    
                    Text(AppConstants.newMessage)
                        .configure(withModifier: secondTextModifier)
                    
                    Spacer()
                    
                    // this was hidden for spacing purposes only
                    
                    let thirdTextModifier = [TextModifier(font: .system(size: screenSize.height * 0.02, weight: .light, design: .rounded), color: AppConstants.customWhite)]
                    
                    Text(AppConstants.cancel)
                        .configure(withModifier: thirdTextModifier)
                }
                .padding(.horizontal, 15.0)
                .padding(.top, 15.0)
                .padding(.bottom, 9.0)
                
                Color(AppConstants.lightGrayThree)
                    .frame(height: 1.0)
            }//: VStack
            .background(Color(AppConstants.customWhite))
            
            Spacer()
            
            // MARK: - BODY
            
            
            // MARK: - FOOTER
        }//: VStack
        .background(Color(AppConstants.lightGrayOne))
    }
}

#Preview {
    Group {
        let isPresentedChatSelect = Binding<Bool>(
            get: { false },
            set: { _ in }
        )
        
        CustomPreview { ChatSelect(screenSize: CGSize(),
                                   isPresentedChatSelect: isPresentedChatSelect) }
    }
}
