//
//  ChatWindow.swift
//  Dishcover
//
//  Created by j8bok on 3/29/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ChatWindow: View {
    
    // MARK: - PROPERTIES
    
    @State private var isKeyboardShowing: Bool = false
    @State private var keyboardHeight: CGFloat = 0.0
    
    private var customBackButton: some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.customGreen)
            
            Image(systemName: AppConstants.arrowBackward)
                .configure(withModifier: imageModifier)
        }
    }
    }
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject private var chatViewModel: ChatViewModel = ChatViewModel.sharedInstance
    
    var body: some View {
        ScreenSizeReader { screenSize in
            ZStack {
                // MARK: - BACKGROUND
                
                Color(AppConstants.lightGrayOne)
                    .edgesIgnoringSafeArea(.all)
                
                // MARK: - HEADER
                
                VStack {
                    // MARK: - BODY
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            let messages = chatViewModel.getMessagesPerSender()
                            let uEmail = UserViewModel.getEmail()
                            
                            ForEach(Array(messages.keys), id: \.self) { key in
                                if let value: ChatDetailsModel = messages[key] {
                                    let message = value.message
                                    let senderEmail = value.senderEmail
                                    
                                    ChatBubble(message: message, isFromSender: true)
                                }
                            }
                        }
                        .padding()
                    }
                    
                    // MARK: - FOOTER
                    
                    Spacer()
                    
                    ChatComposer(screenSize: screenSize)
                        .padding(.bottom, isKeyboardShowing ? keyboardHeight : screenSize.height * 0.06)
                        .animation(.easeInOut, value: isKeyboardShowing)
                }
           
            }//: ZStack
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: customBackButton.frame(width: screenSize.width * 0.034, height: screenSize.height * 0.034))
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.customWhite)
            .toolbar {
                ToolbarItem(placement: .principal, content: {
                    HStack(spacing: 15.0) {
                        Group {
                            let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.customGreen)
                            
                            Image(systemName: "person.circle.fill") // to have the image of sender
                                .configure(withModifier: imageModifier)
                                .clipShape(Circle())
                                .frame(width: screenSize.width * 0.04, height: screenSize.height * 0.04)
                        }
                        
                        VStack(alignment: .leading) {
                            Group {
                                let textModifier = [TextModifier(font: .system(size: screenSize.height * 0.019, weight: .regular, design: .rounded), color: AppConstants.darkGrayTwo)]
                                let firstName = chatViewModel.getFirstName()
                                
                                Text(firstName)
                                    .configure(withModifier: textModifier)
                            }
                            
                            Group {
                                let textModifier = [TextModifier(font: .system(size: screenSize.height * 0.017, weight: .light, design: .rounded), color: AppConstants.darkGrayOne)]
                                let lastName = chatViewModel.getLastName()
                                
                                Text(lastName)
                                    .configure(withModifier: textModifier)
                            }
                        }
                    }
                    .padding(.leading, -(screenSize.width / 2) + screenSize.width * 0.135)
                })
                
                ToolbarItem(placement: .topBarTrailing, content: {
                    HStack(spacing: 35.0) {
                        Group {
                            let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.customGreen)
                            
                            Image(systemName: AppConstants.phoneFill)
                                .configure(withModifier: imageModifier)
                                .frame(width: screenSize.width * 0.03, height: screenSize.height * 0.03)
                        }
                        
                        Group {
                            let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.customGreen)
                            
                            Image(systemName: AppConstants.videoFill)
                                .configure(withModifier: imageModifier)
                                .frame(width: screenSize.width * 0.03, height: screenSize.height * 0.03)
                        }
                    }
                })
            }//: toolbar
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                isKeyboardShowing = true
                
                if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    keyboardHeight = keyboardSize.height + 7.0
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
                isKeyboardShowing = false
                keyboardHeight = 0.0
            }
        }//: ScreenSizeReader
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - PREVIEW

#Preview {
    ChatWindow()
}
