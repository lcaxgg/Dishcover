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
    @Published private var conversations: ArrayOfChatModel = Array()
    @Published var indexOfSender: Int?
    
    // MARK: - METHOD
    
    private init() {}
}

extension ChatViewModel {
    
    // MARK: - GETTER
    
    func getAllMessages() -> ArrayOfChatModel {
        conversations
    }
    
    // for ChatList view
    
    func getSenderName(at index: Int) -> String {
        let chatDetails = conversations[index].chatDetails
        
        for details in chatDetails {
            let senderName = details.1.senderName
            let uName = UserViewModel.getName()
            
            if uName == senderName {
                continue
            } else {
                return senderName
            }
        }
        
        return AppConstants.emptyString
    }
    
    func getLatestMessage(at index: Int) -> String {
        conversations[index].chatDetails.first?.1.message ?? AppConstants.emptyString
    }
    
    func getLatestMessageDateTime(at index: Int) -> String {
        var dateTimeString = conversations[index].chatDetails.first?.0 ?? AppConstants.emptyString
        
        if let formattedDateTime = DateTimeService.formatStringDateTime(of: dateTimeString) {
            dateTimeString = DateTimeService.computeElapsedDateTime(from: formattedDateTime)
        }
        
        return dateTimeString
    }
    
    // for ChatWindow view
    
    func getCurrentFirstName() -> String {
        if let indexOfSender = indexOfSender {
            let components = ChatViewModel.sharedInstance.getSenderName(at: indexOfSender).components(separatedBy: AppConstants.whiteSpaceString)
            return components.first ?? AppConstants.emptyString
        }
        
        return AppConstants.emptyString
    }
    
    func getCurrentLastName() -> String {
        if let indexOfSender = indexOfSender {
            let components = ChatViewModel.sharedInstance.getSenderName(at: indexOfSender).components(separatedBy: AppConstants.whiteSpaceString)
            return components.last ?? AppConstants.emptyString
        }
        
        return AppConstants.emptyString
    }
    
    func getCurrentMessages() -> ArrayOfTupleStringModel {
        if let indexOfSender = indexOfSender {
            let messages = conversations[indexOfSender].chatDetails
            return messages.reversed()
        }
        
        return ArrayOfTupleStringModel()
    }
    
    static func getDocumentId() -> String {
        sharedInstance.composedMessageModel.documentId
    }
    
    static func getComposedMessage() -> String {
        sharedInstance.composedMessageModel.message
    }
    
    //
    //    static func getReceiverEmail() -> String {
    //        sharedInstance.composedMessageModel.receiverEmail
    //    }
    
    // MARK: - SETTER
    
    static func setMessages(with chatModel: inout ChatModel, andWith isForMerging: Bool) {
        let senderName = chatModel.documentId
        
        if let filteredMessage = sharedInstance.conversations.filter( { $0.documentId == senderName }).first, isForMerging {
            let fetchedChatDetails = chatModel.chatDetails
            var newChatDetails = filteredMessage.chatDetails
            
            for (date, details) in fetchedChatDetails {
                newChatDetails.insert((date, details), at: 0)
            }
            
            if let index = sharedInstance.conversations.firstIndex(of: filteredMessage) {
                sharedInstance.conversations[index].chatDetails = newChatDetails
            }
        } else {
            sharedInstance.conversations.append(chatModel)
        }
    }
    
    func setIndexOfSender(with index: Int) {
        indexOfSender = index
    }
    
    func setDocumentId() {
        if let indexOfSender = indexOfSender {
            composedMessageModel.documentId = conversations[indexOfSender].documentId
        }
    }
    
    //    func setReceiverEmail() { // will set in the selection list
    //        if let indexOfSender = indexOfSender {
    //            let value = messages[indexOfSender].chatDetails.first?.1
    //            let receiverEmail = ""
    //
    //            composedMessageModel.receiverEmail = receiverEmail ?? AppConstants.emptyString
    //        }
    //    }
    
    func clearMessage() {
        composedMessageModel.message = AppConstants.emptyString
    }
}

