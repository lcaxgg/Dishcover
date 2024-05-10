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
    
    var screenSize: CGSize
    
    private var customBackButton: some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.customGreen)
            
            Image(systemName: "arrow.backward")
                .configure(withModifier: imageModifier)
        }
    }
    }
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject private var chatViewModel: ChatViewModel = ChatViewModel.sharedInstance
    
    var body: some View {
        ZStack() {
            // MARK: - BACKGROUND
            
            Color(AppConstants.lightGrayOne)
                .edgesIgnoringSafeArea(.all)
            
            // MARK: - HEADER
            
            // MARK: - BODY
            
            // MARK: - FOOTER
            
        }//: ZStack
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
                            
                            Text("First Name")
                                .configure(withModifier: textModifier)
                        }
                        
                        Group {
                            let textModifier = [TextModifier(font: .system(size: screenSize.height * 0.017, weight: .light, design: .rounded), color: AppConstants.darkGrayOne)]
                            
                            Text("Last Name")
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
                        
                        Image(systemName: "phone.fill")
                            .configure(withModifier: imageModifier)
                            .frame(width: screenSize.width * 0.03, height: screenSize.height * 0.03)
                    }
                    
                    Group {
                        let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.customGreen)
                        
                        Image(systemName: "video.fill")
                            .configure(withModifier: imageModifier)
                            .frame(width: screenSize.width * 0.03, height: screenSize.height * 0.03)
                    }
                }
            })
        }
    }
}

// MARK: - PREVIEW

#Preview {
    ChatWindow(screenSize: CGSize())
}
