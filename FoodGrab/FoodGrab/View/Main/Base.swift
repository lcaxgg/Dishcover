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
    
    @State private var isPresentedChatSelect: Bool = false
    
    @State private var navigationBarTitle: String = AppConstants.emptyString
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
                        
                        Chat(screenSize: screenSize,
                             isPresentedChatSelect: $isPresentedChatSelect)
                            .tag(1)
                            .tabItem {
                                Image(systemName: AppConstants.messageFill)
                                Text(AppConstants.chat)
                            }
                            .sheet(isPresented: $isPresentedChatSelect) {
                                ChatWindow()
                            }
                    }
                    .frame(width: screenSize.width)
                    .background(Color(AppConstants.lightGrayOne))
                    .accentColor(Color(AppConstants.green))
                }
            }//: ZStack
        }//: ScreenSizeReader
        .navigationBarTitle(navigationBarTitle, displayMode: .large)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if let selectedEnum = NavigationBarTitleEnum(rawValue: selectedTab) {
                    switch selectedEnum {
                    case .chatNavTitle:
                        Button(action: {
                            isPresentedChatSelect = true
                        }) {
                            Image(systemName: AppConstants.squareAndPencil)
                        }
                    default:
                        EmptyView()
                    }
                }
            }
        }
        .onAppear(perform: {
            UITabBar.appearance().backgroundColor = UIColor.white
            
            processMealsDisplay()
        })
        .onChange(of: selectedTab) { selectedTab in
            setUpNavigationBarTitle(with: selectedTab)
        }
    }
}

extension Base {
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
                            navigationBarTitle = AppConstants.mealNavTitle
                        }
                    }
                }
            }
        }
    }
    
    private func setUpNavigationBarTitle(with selectedTab: Int) {
        if let selectedEnum = NavigationBarTitleEnum(rawValue: selectedTab) {
            switch selectedEnum {
            case .mealsNavTitle:
                navigationBarTitle = AppConstants.mealNavTitle
                
            case .chatNavTitle:
                navigationBarTitle = AppConstants.chat
                
            case .accountNavTitle:
                navigationBarTitle = AppConstants.account
            }
        }
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview {
//    CustomPreview { Base() }
//}
