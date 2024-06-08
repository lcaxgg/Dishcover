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
                
                // MARK: - BODY
                
                //                VStack { // to configure
                //                    let messages = chatViewModel.getMessagesPerSender()
                //
                //                    ForEach(Array(messages.keys), id: \.self) { key in
                //                        if let value: ChatDetailsModel = messages[key] {
                //                            Text("\(key): \(value.message)")
                //                        }
                //                    }
                //                }
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        
                    }
                    
                    // MARK: - FOOTER
                    
                    Spacer()
                    
                    ComposeArea(screenSize: screenSize)
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
                            
                            Image(systemName: "person.circle.fill")
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
        }//: ScreenSizeReader
    }
}

// MARK: - PREVIEW

#Preview {
    ChatWindow()
}
