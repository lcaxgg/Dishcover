//
//  ChatModel.swift
//  Dishcover
//
//  Created by j8bok on 4/6/24.
//

import Foundation

struct ChatModel: Codable, Equatable {
    var id: UUID
    let senderName: String
    var chatDetails: [(String, ChatDetailsModel)]
    
    enum CodingKeys: String, CodingKey {
        case id, senderName, chatDetails
    }
    
    enum ChatDetailsCodingKeys: String, CodingKey {
        case date, chatDetailsModel
    }
    
    init(senderName: String, chatDetails: [(String, ChatDetailsModel)]) {
        self.id = UUID()
        self.senderName = senderName
        self.chatDetails = chatDetails
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        senderName = try container.decode(String.self, forKey: .senderName)
     
        var chatDetailsContainer = try container.nestedUnkeyedContainer(forKey: .chatDetails)
        var decodedChatDetails: [(String, ChatDetailsModel)] = []
        
        while !chatDetailsContainer.isAtEnd {
            let detailContainer = try chatDetailsContainer.nestedContainer(keyedBy: ChatDetailsCodingKeys.self)
         
            let dateString = try detailContainer.decode(String.self, forKey: .date)
            let chatDetailsModel = try detailContainer.decode(ChatDetailsModel.self, forKey: .chatDetailsModel)
         
            decodedChatDetails.append((dateString, chatDetailsModel))
        }
      
        chatDetails = decodedChatDetails
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
       
        try container.encode(id, forKey: .id)
        try container.encode(senderName, forKey: .senderName)
        
        var detailsContainer = container.nestedUnkeyedContainer(forKey: .chatDetails)
      
        for (key, value) in chatDetails {
            var detailContainer = detailsContainer.nestedContainer(keyedBy: ChatDetailsModel.CodingKeys.self)
            
            try detailContainer.encode(value.isRead, forKey: .isRead)
            try detailContainer.encode(value.message, forKey: .message)
            try detailContainer.encode(value.senderEmail, forKey: .senderEmail)
        }
    }
    
    static func == (lhs: ChatModel, rhs: ChatModel) -> Bool {
        lhs.senderName == rhs.senderName
    }
}

struct ChatDetailsModel: Codable {
    let isRead: Bool
    let message: String
    let senderEmail: String
    
    enum CodingKeys: String, CodingKey {
        case isRead = "is_read"
        case message
        case senderEmail = "sender_email"
    }
}

struct ComposedMessageModel {
    var receiverEmail: String = AppConstants.emptyString
    var message: String = AppConstants.emptyString
}
