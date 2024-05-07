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
    
    private static let sharedInstance: ChatViewModel = ChatViewModel()
    @Published private var messages: ArrayOfChatModel = Array()
    
    // MARK: - METHOD
    
    private init() {}
    
    static func getSharedInstance() -> ChatViewModel {
        sharedInstance
    }
}

extension ChatViewModel {
    
    // MARK: - GETTER
    
    func getMessages() -> ArrayOfChatModel {
        messages
    }
    
    static func getSenderName(at index: Int) -> String {
        sharedInstance.messages[index].senderName
    }
    
    static func getMessageDateTime(at index: Int) -> String {
        var dateTimeString = sharedInstance.messages[index].chatDetails.keys.first ?? AppConstants.emptyString
       
        if let formattedDateTime = DateTimeService.formatStringDateTime(of: dateTimeString) {
            dateTimeString = DateTimeService.computeElapsedDateTime(from: formattedDateTime)
        }
        
        return dateTimeString
    }
    
    static func getLatestMessage(at index: Int) -> String {
        sharedInstance.messages[index].chatDetails.values.first?.message ?? AppConstants.emptyString
    }
    
    // MARK: - SETTER
    
    static func setMessages(with chatModel: inout ChatModel, andWith isForMerging: Bool) {
        let senderName = chatModel.senderName
        
        if let filteredMessage = sharedInstance.messages.filter( { $0.senderName == senderName }).first, isForMerging {
            let senderChatDetails = chatModel.chatDetails
            let date = senderChatDetails.keys.first ?? AppConstants.emptyString
            let detailsToMerge = senderChatDetails.values.first
            
            var newChatDetails = filteredMessage.chatDetails
            newChatDetails[date] = detailsToMerge
            
            if let index = sharedInstance.messages.firstIndex(of: filteredMessage) {
                sharedInstance.messages[index].chatDetails = newChatDetails
            }
        } else {
            sharedInstance.messages.append(chatModel)
        }
    }
}

