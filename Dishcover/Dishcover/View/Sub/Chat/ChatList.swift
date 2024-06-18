//
//  ChatList.swift
//  Dishcover
//
//  Created by j8bok on 3/29/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ChatList: View {
    
    // MARK: - PROPERTIES
    
    var screenSize: CGSize
    var index: Int?
    
    @ObservedObject private var chatViewModel: ChatViewModel = ChatViewModel.sharedInstance
    
    var body: some View {
        if let index = index {
            HStack(alignment: .center, spacing: 20.0) {
                Group {
                    Color(AppConstants.lightGrayTwo)
                        .frame(width: screenSize.width * 0.12, height: screenSize.height * 0.065)
                        .cornerRadius(13.0)
                        .overlay(
                            Group {
                                let firstImageModifier = ImageModifier(contentMode: .fill, color: AppConstants.customWhite)
                                
                                Image(systemName: AppConstants.personXmark)
                                    .configure(withModifier: firstImageModifier)
                                    .opacity(0.7)
                                    .frame(width: screenSize.width * 0.07, height: screenSize.height * 0.032)
                            }
                                .padding(.top, 2.0)
                                .padding(.trailing, 2.0)
                        )
                }
            
                VStack(spacing: 8.0) {
                    HStack {
                        Group {
                            let firstTextModifier = [TextModifier(font: .system(size: 16.0, weight: .semibold, design: .rounded), color: AppConstants.customBlack)]
                            let senderName = chatViewModel.getSenderName(at: index)
                            
                            Text(senderName)
                                .configure(withModifier: firstTextModifier)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 5.0) {
                            Group {
                                let secondTextModifier = [TextModifier(font: .system(size: 13.0, weight: .light, design: .rounded), color: AppConstants.customBlack)]
                                let dateTime = chatViewModel.getLatestMessageDateTime(at: index)
                                
                                Text(dateTime)
                                    .configure(withModifier: secondTextModifier)
                            }
                            
                            Group {
                                let secondImageModifier = ImageModifier(contentMode: .fill, color: AppConstants.customBlack)
                                
                                Image(systemName: AppConstants.chevronRight)
                                    .configure(withModifier: secondImageModifier)
                                    .opacity(0.7)
                                    .frame(width: screenSize.width * 0.014, height: screenSize.height * 0.014)
                            }
                        }
                    }
                   
                    HStack {
                        Group {
                            let thirdTextModifier = [TextModifier(font: .system(size: 14.0, weight: .light, design: .rounded), color: AppConstants.darkGrayOne)]
                            let latestMessage = chatViewModel.getLatestMessage(at: index)
                            
                            Text(latestMessage)
                                .configure(withModifier: thirdTextModifier)
                                .lineLimit(2)
                                .lineSpacing(1.0)
                        }
                        
                        Spacer()
                    }
                }
            }//: HStack
            .background(Color(AppConstants.lightGrayOne))
        }
    }
}

// MARK: - PREVIEW

#Preview {
    ChatList(screenSize: CGSize())
}
