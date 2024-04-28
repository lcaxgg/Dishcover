//
//  ChatViewModel.swift
//  FoodGrab
//
//  Created by j8bok on 4/26/24.
//

import Foundation

class ChatViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
   
    static let shared: ChatViewModel = ChatViewModel()
    //private var chatModel: ChatModel = ChatModel(senderName: AppConstants.emptyString, chatDetails: Array())
    
    var messages: [ChatModel] = Array()
    
    // MARK: - METHOD
    
    private init() {}
    
    static func getSharedInstance() -> ChatViewModel {
        ChatViewModel.shared
    }
}

extension ChatViewModel {
    
    // MARK: - GETTER

    static func getMessages() -> [ChatModel] {
        ChatViewModel.shared.messages
    }
    
    // MARK: - SETTER

    static func setMessages(with chatModel: ChatModel) {
        ChatViewModel.shared.messages.append(chatModel)
    }
}

