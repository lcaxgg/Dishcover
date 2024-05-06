//
//  ChatModel.swift
//  Dishcover
//
//  Created by j8bok on 4/6/24.
//

import Foundation

struct ChatModel: Codable, Equatable {
    var id: UUID = UUID()
    let senderName: String
    var chatDetails: [String: ChatDetailsModel]
    
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
