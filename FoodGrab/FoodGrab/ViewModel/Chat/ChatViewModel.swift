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
    private var chatModel: ChatModel = ChatModel()
    
    var messages: [[String: [[String: ChatDetailsModel]]]] = Array()
    
    // MARK: - METHOD
    
    private init() {}
    
    static func getSharedInstance() -> ChatViewModel {
        ChatViewModel.shared
    }
}

extension ChatViewModel {
    
    // MARK: - GETTER

    static func getMessages() -> [[String: [[String: ChatDetailsModel]]]] {
        ChatViewModel.shared.messages
    }
    
    // MARK: - SETTER

    static func setMessages(with sender: String, andWith chatDetails: [[String: ChatDetailsModel]]) {
        ChatViewModel.shared.messages.append([sender: chatDetails])
    }
}

