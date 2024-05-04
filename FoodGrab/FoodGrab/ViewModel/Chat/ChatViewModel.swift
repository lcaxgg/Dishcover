//
//  ChatViewModel.swift
//  FoodGrab
//
//  Created by j8bok on 4/26/24.
//

import Foundation

class ChatViewModel: ObservableObject {
    
    // MARK: - TYPES
    
    typealias ArrayOfChatModel = [ChatModel]
    
    // MARK: - PROPERTIES
   
    static let shared: ChatViewModel = ChatViewModel()
    var messages: ArrayOfChatModel = Array()
    
    // MARK: - METHOD
    
    private init() {}
    
    static func getSharedInstance() -> ChatViewModel {
        ChatViewModel.shared
    }
}

extension ChatViewModel {
    
    // MARK: - GETTER

    static func getMessages() -> ArrayOfChatModel {
        ChatViewModel.shared.messages
    }
    
    // MARK: - SETTER

    static func setMessages(with chatModel: ChatModel, andWith isForMerging: Bool) {
        if isForMerging {
            let senderName = chatModel.senderName
            let senderChatDetails = chatModel.chatDetails
            let date = senderChatDetails.keys.first ?? AppConstants.emptyString
            let detailsToMerge = senderChatDetails.values.first
            
            let filteredMessage = ChatViewModel.shared.messages.filter( { $0.senderName == senderName }).first
           
            var newChatDetails = filteredMessage?.chatDetails ?? [:]
            newChatDetails[date] = detailsToMerge
        
            if let index = ChatViewModel.shared.messages.firstIndex(of: filteredMessage!) {
                ChatViewModel.shared.messages[index].chatDetails = newChatDetails
            }
        } else {
            ChatViewModel.shared.messages.append(chatModel)
        }
    }
}

