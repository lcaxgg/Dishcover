//
//  ChatModel.swift
//  FoodGrab
//
//  Created by j8bok on 4/6/24.
//

import Foundation

struct ChatModel: Codable {
    let senderName: String
    let chatDetails: [[String: ChatDetailsModel]]
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
