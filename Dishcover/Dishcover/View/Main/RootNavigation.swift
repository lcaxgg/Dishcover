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
            .navigationDestination(for: NavigationRoute.self) { route in
                switch route {
                case .register:
                    Register()
                case .login:
                    Login(navigationPath: $navigationPath)
                case .base:
                    Base()
                }
            }
        }//: NavigationStack
        .accentColor(Color(AppConstants.customGreen))
    }
}

#Preview {
    RootNavigation()
}
