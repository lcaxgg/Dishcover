//
//  ChatViewModel.swift
//  Dishcover
//
//  Created by j8bok on 4/26/24.
//

import Foundation

class ChatViewModel: ObservableObject {
    
    // MARK: - TYPES
    
    typealias ArrayOfChatModel = [ChatModel]
    
    // MARK: - PROPERTIES
    
    private static let shared: ChatViewModel = ChatViewModel()
    @Published private var messages: ArrayOfChatModel = Array()
    
    // MARK: - METHOD
    
    private init() {}
    
    static func getSharedInstance() -> ChatViewModel {
        shared
    }
}

extension ChatViewModel {
    
    // MARK: - GETTER
    
   func getMessages() -> ArrayOfChatModel {
        messages
    }
    
    // MARK: - SETTER
    
    static func setMessages(with chatModel: ChatModel, andWith isForMerging: Bool) {
        let senderName = chatModel.senderName
        
        if let filteredMessage = shared.messages.filter( { $0.senderName == senderName }).first, isForMerging {
            let senderChatDetails = chatModel.chatDetails
            let date = senderChatDetails.keys.first ?? AppConstants.emptyString
            let detailsToMerge = senderChatDetails.values.first
            
            var newChatDetails = filteredMessage.chatDetails
            newChatDetails[date] = detailsToMerge
            
            if let index = shared.messages.firstIndex(of: filteredMessage) {
                shared.messages[index].chatDetails = newChatDetails
            }
        } else {
            shared.messages.append(chatModel)
        }
    }
}

