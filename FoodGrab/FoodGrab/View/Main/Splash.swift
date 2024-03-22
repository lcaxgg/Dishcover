//
//  Splash.swift
//  FoodGrab
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
                Welcome()
                    .transition(.opacity)
            } else {
                GeometryReader { geometry in
                    ZStack {
                        Color(AppConstants.green)
                            .ignoresSafeArea(.all)
                        
                        Logo(color: AppConstants.white)
                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.3)
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

@available(iOS 17, *)
#Preview {
    CustomPreview { Splash() }
}
