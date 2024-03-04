//
//  SearchField.swift
//  FoodGrab
//
//  Created by j8bok on 10/6/23.
//

import SwiftUI
import UIKit

struct SearchField: View {
    
    // MARK: - PROPERTIES
    
    var geometry: GeometryProxy
    @Binding var searchText: String
    @ObservedObject var searchViewModel: SearchViewModel
    
    var body: some View {
        HStack {
            let imageModifier = ImageModifier(contentMode: .fit, color: AppConstants.green)
            
            Image(systemName: AppConstants.magnifyingglass)
                .configure(withModifier: imageModifier)
                .frame(width: geometry.size.width * 0.048, height: geometry.size.height * 0.048)
                .padding(.leading, geometry.size.width * 0.035)
            
            TextField(AppConstants.searchPlaceHolder, text: $searchViewModel.searchModel.searchText)
                .autocapitalization(.none)
                .keyboardType(.default)
                .submitLabel(.done)
                .padding()
                .overlay {
                    if !searchViewModel.getSearchText().isEmpty {
                        HStack {
                            Spacer()
                           
                            Button(action: {
                                searchViewModel.setSearchText(with: AppConstants.emptyString)
                            }) {
                                Image(systemName: AppConstants.xCircle)
                                    .foregroundColor(Color(AppConstants.darkGray).opacity(0.6))
                            }
                            .padding(.trailing, geometry.size.width * 0.035)
                        }
                    }
                }
        }
        .background(Color(AppConstants.white))
        .accentColor(Color(AppConstants.green))
        .cornerRadius(13.0)
    }
}

// MARK: - PREVIEW

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        
        GeometryReader { geometry in
            let textBinding = Binding<String>(
                get: { AppConstants.emptyString },
                set: { _ in }
            )
            
            CustomPreview { SearchField(geometry: geometry,
                                        searchText: textBinding,
                                        searchViewModel: SearchViewModel()) }
        }
    }
}
