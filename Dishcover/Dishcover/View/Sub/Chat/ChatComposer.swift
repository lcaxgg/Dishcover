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
    
    @State private var didTapSend: Bool = false
    @ObservedObject private var chatViewModel: ChatViewModel = ChatViewModel.sharedInstance
    
    var body: some View {
        HStack(spacing: 20.0) {
            withAnimation(.easeInOut) {
                TextField(AppConstants.messagePlaceHolder, text: $chatViewModel.messageContent.message, axis: .vertical)
                    .lineLimit(...5)
            }
            
            Group {
                let isEnabled = !chatViewModel.messageContent.message.isEmpty
                let imageModifier = ImageModifier(contentMode: .fill,
                                                  color: isEnabled ? AppConstants.customGreen : AppConstants.lightGrayTwo)
  
                Image(systemName: AppConstants.paperPlaneCircelFill)
                    .configure(withModifier: imageModifier)
                    .rotationEffect(.degrees(45.0))
                    .frame(width: screenSize.width * 0.04, height: screenSize.height * 0.04)
                    .opacity(didTapSend ? 0 : 1)
                    .onTapGesture {
                        if isEnabled {
                            didTapSend = true
                            
                            DispatchQueue.global(qos: .userInitiated).async {
                                ChatManager.sendMessage()
                                
                                DispatchQueue.main.async {
                                    withAnimation {
                                        didTapSend = false
                                        chatViewModel.clearMessage()
                                    }
                                }
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

@available(iOS 17, *)
#Preview {
    CustomPreview { ChatComposer(screenSize: CGSize()) }
}
