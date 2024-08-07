//
//  SearchField.swift
//  Dishcover
//
//  Created by j8bok on 10/6/23.
//

import SwiftUI
import UIKit

struct SearchField: View {
    
    // MARK: - PROPERTIES
    
    var screenSize: CGSize
    @Binding var searchText: String

    @EnvironmentObject var searchViewModel: SearchViewModel
    
    var body: some View {
        HStack {
            let imageModifier = ImageModifier(contentMode: .fit, color: AppConstants.customGreen)
            
            Image(systemName: AppConstants.magnifyingglass)
                .configure(withModifier: imageModifier)
                .frame(width: screenSize.width * 0.048, height: screenSize.height * 0.048)
                .padding(.leading, screenSize.width * 0.035)
            
            TextField(AppConstants.searchPlaceHolder, text: $searchViewModel.searchModel.searchText)
                .autocapitalization(.none)
                .keyboardType(.default)
                .submitLabel(.done)
                .padding()
                .overlay {
                    if !searchViewModel.searchModel.searchText.isEmpty {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                searchViewModel.setSearchText(with: AppConstants.emptyString)
                            }) {
                                Image(systemName: AppConstants.xCircle)
                                    .foregroundColor(Color(AppConstants.darkGrayTwo).opacity(0.6))
                            }
                            .padding(.trailing, screenSize.width * 0.035)
                        }
                    }
                }
        }
        .background(Color(AppConstants.customWhite))
        .accentColor(Color(AppConstants.customGreen))
        .cornerRadius(13.0)
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview {
//    Group {
//        let textBinding = Binding<String>(
//            get: { AppConstants.emptyString },
//            set: { _ in }
//        )
//        
//        CustomPreview { SearchField(screenSize: CGSize(),
//                                    searchText: textBinding) }
//    }
//}
