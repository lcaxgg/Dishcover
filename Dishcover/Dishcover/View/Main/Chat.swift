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
    @State private var isPresentedChatWindow: Bool = false
    
    @ObservedObject private var chatViewModel: ChatViewModel = ChatViewModel.sharedInstance
    
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
                            let messagesCount = chatViewModel.getMessages().count
                            
                            ForEach(0..<messagesCount, id: \.self) { index in
                                ChatList(screenSize: screenSize, index: index)
                                    .onTapGesture {
                                        isPresentedChatWindow.toggle()
                                    }
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
                    .overlay {
                        NavigationLink(AppConstants.emptyString, destination: ChatWindow(screenSize: screenSize), isActive: $isPresentedChatWindow).opacity(0)
                    }
                    .onAppear(perform: {
                        setNavigationViewItemTag()
                    })
                } else {
                    // Fallback on earlier versions
                }
                
                // MARK: - FOOTER
            }
        }//: ZStack
    }
    
    private func setNavigationViewItemTag() {
        guard NavigationViewModel.getNavigationViewItemTag() != NavigationViewItemEnum.chat.rawValue else {
            return
        }
        
        NavigationViewModel.setNavigationViewItemTag(with: NavigationViewItemEnum.chat.rawValue)
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
