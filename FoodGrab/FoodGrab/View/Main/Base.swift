//
//  Base.swift
//  FoodGrab
//
//  Created by j8bok on 3/18/24.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct Base: View {
    
    // MARK: - PROPERTIES
    
    @State private var isDownloadComplete: Bool = false
    @State private var isLoadingVisible: Bool = true
    @State private var isAnimating: Bool = false
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        ScreenSizeReader { screenSize in
            ZStack {
                // MARK: - HEADER
                
                Color(AppConstants.lightGrayOne)
                    .edgesIgnoringSafeArea(.all)
                
                // MARK: - BODY
                
                if !isDownloadComplete {
                    VStack(spacing: -55.0) {
                        
                        Logo(color: AppConstants.green)
                            .frame(width: isAnimating ?  nil : screenSize.width * 0.3, height: isAnimating ? nil : screenSize.height * 0.3)
                            .scaleEffect(isAnimating ? 3.0 : 1.0)
                           
                        LoadingIndicator(animation: .threeBalls, color: Color(AppConstants.green), size: .medium, speed: .normal)
                            .opacity(isLoadingVisible ? 1 : 0)
                    }
                } else {
                    
                    // MARK: - FOOTER
                    
                    TabView(selection: $selectedTab) {
                        Meals(screenSize: screenSize)
                            .tag(0)
                            .tabItem {
                                Image(systemName: AppConstants.squareGrid)
                                Text(AppConstants.meals)
                            }
                        
                        Chat()
                            .tag(1)
                            .tabItem {
                                Image(systemName: AppConstants.messageFill)
                                Text(AppConstants.chat)
                            }
                    }
                    .frame(width: screenSize.width)
                    .background(Color(AppConstants.lightGrayOne))
                    .accentColor(Color(AppConstants.green))
                }
            }//: ZStack
        }//: ScreenSizeReader
        .onAppear(perform: {
            UITabBar.appearance().backgroundColor = UIColor.white
            
            processMealsDisplay()
        })
    }
    
    private func processMealsDisplay() {
        if !isDownloadComplete {
            MealsService.processMealsDataForDisplay { success in
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.65) {
                        isLoadingVisible.toggle()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                        withAnimation(Animation.easeOut(duration: 0.40)) {
                            isAnimating.toggle()
                        }
                        
                        withAnimation(Animation.easeIn(duration: 0.30)) {
                            isDownloadComplete = success
                        }
                    }
                }
            }
        }
    }
}

// MARK: - PREVIEW

#Preview {
    CustomPreview { Base() }
}
