//
//  Base.swift
//  Dishcover
//
//  Created by j8bok on 3/18/24.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct Base: View {
    
    // MARK: - PROPERTIES
    
    @State private var isDownloadingMealsComplete: Bool = false
    @State private var isFetchingMessagesComplete: Bool = false
    @State private var isLoadingVisible: Bool = true
    @State private var isAnimating: Bool = false
    
    @State private var isPresentedChatSelect: Bool = false
    
    @State private var navigationBarTitle: String = AppConstants.emptyString
    @State private var selectedTab: Int = 0
    
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        ScreenSizeReader { screenSize in
            ZStack {
                // MARK: - BACKGROUND
                
                Color(AppConstants.lightGrayOne)
                    .edgesIgnoringSafeArea(.all)
                
                // MARK: - HEADER
                
                // MARK: - BODY
                
                if !isDownloadingMealsComplete {
                    VStack(spacing: -55.0) {
                        
                        Logo(color: AppConstants.customGreen)
                            .frame(width: isAnimating ?  nil : screenSize.width * 0.3, height: isAnimating ? nil : screenSize.height * 0.3)
                            .scaleEffect(isAnimating ? 3.0 : 1.0)
                        
                        LoadingIndicator(animation: .threeBalls, color: Color(AppConstants.customGreen), size: .medium, speed: .normal)
                            .opacity(isLoadingVisible ? 1 : 0)
                    }
                } else {
                    Meals(screenSize: screenSize, navigationPath: $navigationPath)
                }
                    
                    // MARK: - FOOTER
                    
//                    TabView(selection: $selectedTab) {
//                        Meals(screenSize: screenSize)
//                            .tag(0)
//                            .tabItem {
//                                Image(systemName: AppConstants.squareGrid)
//                                Text(AppConstants.meals)
//                            }
//                        
//                        Chat(screenSize: screenSize,
//                             isPresentedChatSelect: $isPresentedChatSelect,
//                             navigationPath: $navigationPath)
//                            .tag(1)
//                            .tabItem {
//                                Image(systemName: AppConstants.messageFill)
//                                Text(AppConstants.chat)
//                            }
//                    }
//                    .frame(width: screenSize.width)
//                    .background(Color(AppConstants.lightGrayOne))
//                    .accentColor(Color(AppConstants.customGreen))
                //}
            }//: ZStack
        }//: ScreenSizeReader
        .navigationBarTitle(navigationBarTitle, displayMode: .large)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                if let selectedEnum = NavigationBarTitleEnum(rawValue: selectedTab) {
//                    switch selectedEnum {
//                    case .chatNavTitle:
//                        Button(action: {
//                            isPresentedChatSelect = true
//                        }) {
//                            Image(systemName: AppConstants.squareAndPencil)
//                        }
//                    default:
//                        EmptyView()
//                    }
//                }
//            }
//        }
        .onAppear(perform: {
            UITabBar.appearance().backgroundColor = UIColor.white
    
            processMealsDisplay()
           // fetchMessages()
        })
//        .onChange(of: selectedTab) { selectedTab in
//            setUpNavigationBarTitle(with: selectedTab)
//        }
    }
}

extension Base {
//    private func setUpNavigationBarTitle(with selectedTab: Int) {
//        if let selectedEnum = NavigationBarTitleEnum(rawValue: selectedTab) {
//            switch selectedEnum {
//            case .mealsNavTitle:
//                navigationBarTitle = AppConstants.mealNavTitle
//                
//            case .chatNavTitle:
//                navigationBarTitle = AppConstants.chat
//                
//            case .accountNavTitle:
//                navigationBarTitle = AppConstants.account
//            }
//        }
//    }
    
    private func processMealsDisplay() {
        if !isDownloadingMealsComplete {
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
                            isDownloadingMealsComplete = success
                            navigationBarTitle = AppConstants.mealNavTitle
                        }
                    }
                }
            }
        }
    }
    
//    private func fetchMessages() {
//        if !isFetchingMessagesComplete {
//            ChatManager.fetchMessages { success in
//                if success {
//                    isFetchingMessagesComplete = success
//                }
//            }
//        }
//    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview {
//    CustomPreview { Base() }
//}
