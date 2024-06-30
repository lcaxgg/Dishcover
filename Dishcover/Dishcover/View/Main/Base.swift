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
    
    @State private var isDownloadingComplete: Bool = false
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
                
                if !isDownloadingComplete {
                    VStack(spacing: -55.0) {
                        Logo(color: AppConstants.customGreen)
                            .frame(width: screenSize.width * 0.3, height: screenSize.height * 0.3)

                        LoadingIndicator(animation: .threeBalls, color: Color(AppConstants.customGreen), size: .medium, speed: .normal)
                    }
                    .opacity(isLoadingVisible ? 1 : 0)
                    
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
                             isPresentedChatSelect: $isPresentedChatSelect,
                             navigationPath: $navigationPath)
                        .tag(1)
                        .tabItem {
                            Image(systemName: AppConstants.messageFill)
                            Text(AppConstants.chat)
                        }
                    }
                    .frame(width: screenSize.width)
                    .background(Color(AppConstants.lightGrayOne))
                    .accentColor(Color(AppConstants.customGreen))
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
            
            processDataForDisplay()
        })
        .onChange(of: selectedTab) { selectedTab in
            setUpNavigationBarTitle(with: selectedTab)
        }
    }
}

extension Base {
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
    
    private func processDataForDisplay() {
        let dispatchGroup = DispatchGroup()
        
        var isDownloadingMealsComplete = false
        var isFetchingMessagesComplete = false
        
        if !isDownloadingComplete {
            dispatchGroup.enter()
            MealsService.processMealsDataForDisplay { success in
                defer {
                    dispatchGroup.leave()
                }
                
                if success {
                    isDownloadingMealsComplete = success
                }
            }
            
            dispatchGroup.enter()
            ChatManager.fetchMessages { success in
                defer {
                    dispatchGroup.leave()
                }
                
                if success {
                    isFetchingMessagesComplete = success
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if isDownloadingMealsComplete && isFetchingMessagesComplete {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.50) {
                    withAnimation(Animation.easeOut(duration: 0.30)) {
                        isLoadingVisible = false
                    }
                    
                    withAnimation(Animation.easeIn(duration: 0.30)) {
                        isDownloadingComplete = true
                        navigationBarTitle = AppConstants.mealNavTitle
                    }
                }
            }
        }
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview {
//    CustomPreview { Base() }
//}
