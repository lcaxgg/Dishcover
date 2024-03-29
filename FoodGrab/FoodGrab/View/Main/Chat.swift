//
//  Chat.swift
//  FoodGrab
//
//  Created by j8bok on 3/17/24.
//

import SwiftUI

struct Chat: View {
    
    // MARK: - PROPERTIES
    
    var screenSize: CGSize
    
    @State private var searchText: String = AppConstants.emptyString
    @FocusState private var isSearchFieldFocused: Bool
    @State private var searchViewModel: SearchViewModel = SearchViewModel()
    
    let itemCount = 5 // temp

    var body: some View {
        ZStack {
            Color(AppConstants.lightGrayOne)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // MARK: - HEADER
                
                SearchField(screenSize: screenSize, searchText: $searchText)
                    .environmentObject(searchViewModel)
                    .padding(.horizontal, 20.0)
                    .padding(.top, screenSize.height * 0.014)
                    .focused($isSearchFieldFocused)
                    .onTapGesture {
                        searchViewModel.setIsSearchFieldFocused(with: true)
                        searchViewModel.setIsSearching(with: true)
                    }
                    .bindFocusState(searchViewModel.getIsSearchFieldFocused(), with: _isSearchFieldFocused)
                
                // MARK: - BODY
                
                if #available(iOS 16.0, *) {
                    List {
                        Section {
                            ForEach(0..<itemCount, id: \.self) { index in
                                ChatList(screenSize: screenSize)
                            }
                            .onDelete(perform: { indexSet in
                                
                            })
                        }
                        .listSectionSeparator(.hidden, edges: .bottom)
                        .listRowBackground(Color(AppConstants.lightGrayOne))
                        .padding(.vertical, 8.0)
                    }
                    .background(Color(AppConstants.lightGrayOne))
                    .scrollContentBackground(.hidden)
                    .listStyle(.inset)
                    .padding(.top, 10.0)
                } else {
                    // Fallback on earlier versions
                }
               
                // MARK: - FOOTER
            }
        }//: ZStack
    }
}

// MARK: - PREVIEW

@available(iOS 17, *)
#Preview {
    CustomPreview { Chat(screenSize: CGSize()) }
}
