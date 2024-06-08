//
//  Splash.swift
//  Dishcover
//
//  Created by j8bok on 8/30/23.
//

import SwiftUI

struct Splash: View {
    
    // MARK: - PROPERTIES
    
    @State private var showWelcome = false
    
    var body: some View {
        ZStack {
            if showWelcome {
                RootNavigation()
                    .transition(.opacity)
            } else {
                ScreenSizeReader { screenSize in
                    ZStack {
                        Color(AppConstants.customGreen)
                            .ignoresSafeArea(.all)
                        
                        Logo(color: AppConstants.customWhite)
                            .frame(width: screenSize.width * 0.3, height: screenSize.height * 0.3)
                            .opacity(showWelcome ? 0.0 : 1.0)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    withAnimation {
                                        showWelcome.toggle()
                                    }
                                }
                            }
                    }
                }
            }
        }//: ZStack
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview {
//    CustomPreview { Splash() }
//}
