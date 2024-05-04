//
//  Chat.swift
//  Dishcover
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
    
    @Binding var isPresentedChatSelect: Bool
    
    @ObservedObject private var chatViewModel: ChatViewModel = ChatViewModel.getSharedInstance()

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
                    .bindFocusState($searchViewModel.searchModel.isSearchFieldFocused, with: _isSearchFieldFocused)
                
                // MARK: - BODY
                
                if #available(iOS 16.0, *) {
                    List {
                        Section {
                            let messages = chatViewModel.getMessages()
                            
                            ForEach(0..<messages.count, id: \.self) { index in
                                ChatList(screenSize: screenSize)
                            }
                            .onDelete(perform: { indexSet in
                                
                            })
                        }
                        .listSectionSeparator(.visible, edges: .bottom)
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
    CustomPreview {
        let isPresented = Binding<Bool>(
            get: { false },
            set: { _ in }
        )
        
        Chat(screenSize: CGSize(), isPresentedChatSelect: isPresented)
    }
}