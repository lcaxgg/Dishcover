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
    typealias ArrayOfTupleStringModel = [(String, ChatDetailsModel)]
    
    // MARK: - PROPERTIES
    
    static let sharedInstance: ChatViewModel = ChatViewModel()
    
    @Published var composedMessageModel: ComposedMessageModel = ComposedMessageModel()
    @Published private var messages: ArrayOfChatModel = Array()
    @Published private var messagesPerSender: ChatModel = ChatModel(senderName: AppConstants.emptyString, chatDetails: Array())
 
    // MARK: - METHOD
    
    private init() {}
}

extension ChatViewModel {
    
    // MARK: - GETTER
    
    func getAllMessages() -> ArrayOfChatModel {
        messages
    }
    
    static func getSenderName(at index: Int) -> String {
        sharedInstance.messages[index].senderName
    }
    
    static func getLatestMessageDateTime(at index: Int) -> String {
        var dateTimeString = sharedInstance.messages[index].chatDetails.first?.0 ?? AppConstants.emptyString
        
        if let formattedDateTime = DateTimeService.formatStringDateTime(of: dateTimeString) {
            dateTimeString = DateTimeService.computeElapsedDateTime(from: formattedDateTime)
        }
        
        return dateTimeString
    }
    
    static func getLatestMessage(at index: Int) -> String {
        sharedInstance.messages[index].chatDetails.first?.1.message ?? AppConstants.emptyString
    }
    
    func getCurrentFirstName() -> String {
        let components = ChatViewModel.sharedInstance.messagesPerSender.senderName.components(separatedBy: AppConstants.whiteSpaceString)
        return components.first ?? AppConstants.emptyString
    }
    
    func getCurrentLastName() -> String {
        let components = ChatViewModel.sharedInstance.messagesPerSender.senderName.components(separatedBy: AppConstants.whiteSpaceString)
        return components.last ?? AppConstants.emptyString
    }
    
    func getCurrentEmail() -> String {
        let value = ChatViewModel.sharedInstance.messagesPerSender.chatDetails.first?.1
        return value?.senderEmail ?? AppConstants.emptyString
    }
    
    func getCurrentMessages() -> ArrayOfTupleStringModel {
        ChatViewModel.sharedInstance.messagesPerSender.chatDetails.reversed()
    }
    
    static func getComposedMessage() -> String {
        sharedInstance.composedMessageModel.message
    }
    
    static func getReceiverEmail() -> String {
        sharedInstance.composedMessageModel.receiverEmail
    }
    
    // MARK: - SETTER
    
    static func setMessages(with chatModel: inout ChatModel, andWith isForMerging: Bool) {
        let senderName = chatModel.senderName
        
        if let filteredMessage = sharedInstance.messages.filter( { $0.senderName == senderName }).first, isForMerging {
            let fetchedChatDetails = chatModel.chatDetails
            var newChatDetails = filteredMessage.chatDetails
            
            for (date, details) in fetchedChatDetails {
                newChatDetails.insert((date, details), at: 0)
            }

            if let index = sharedInstance.messages.firstIndex(of: filteredMessage) {
                sharedInstance.messages[index].chatDetails = newChatDetails
            }
        } else {
            sharedInstance.messages.append(chatModel)
        }
    }
    
    func setMessagePerSender(with index: Int) {
        messagesPerSender = getAllMessages()[index]
    }
    
    func setReceiverEmail() {
        let value = messagesPerSender.chatDetails.first?.1
        let receiverEmail = value?.senderEmail
        
        composedMessageModel.receiverEmail = receiverEmail ?? AppConstants.emptyString
    }
    
    func clearMessage() {
        composedMessageModel.message = AppConstants.emptyString
    }
}

