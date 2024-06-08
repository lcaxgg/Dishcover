//
//  RootNavigation.swift
//  Dishcover
//
//  Created by j8bok on 6/8/24.
//

import SwiftUI

struct RootNavigation: View {
    
    // MARK: - PROPERTIES
    
    @State private var navigationPath: NavigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Welcome(navigationPath: $navigationPath)
                    .onAppear {
                        NavigationViewModel.setNavigationViewItemTag(with: NavigationViewItemEnum.welcome.rawValue)
                    }
            }
            .navigationDestination(for: NavigationRoute.self) { navigationRoute in
                switch navigationRoute {
                case .register:
                    Register(navigationPath: $navigationPath)
                case .login:
                    Login(navigationPath: $navigationPath)
                case .base:
                    Base(navigationPath: $navigationPath)
                case .chatWindow:
                    ChatWindow()
                }
            }
        }//: NavigationStack
        .accentColor(Color(AppConstants.customGreen))
    }
}

#Preview {
    RootNavigation()
}
