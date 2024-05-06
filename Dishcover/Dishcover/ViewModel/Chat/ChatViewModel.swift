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
    
    static func getSenderName(at index: Int) -> String {
        shared.messages[index].senderName
    }
    
    static func getMessageDateTime(at index: Int) -> String {
        var dateTimeString = shared.messages[index].chatDetails.keys.first ?? AppConstants.emptyString
       
        if let formattedDateTime = DateTimeService.formatStringDateTime(of: dateTimeString) {
            dateTimeString = DateTimeService.computeElapsedDateTime(from: formattedDateTime)
        }
        
        return dateTimeString
    }
    
    static func getLatestMessage(at index: Int) -> String {
        shared.messages[index].chatDetails.values.first?.message ?? AppConstants.emptyString
    }
    
    // MARK: - SETTER
    
    static func setMessages(with chatModel: inout ChatModel, andWith isForMerging: Bool) {
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

