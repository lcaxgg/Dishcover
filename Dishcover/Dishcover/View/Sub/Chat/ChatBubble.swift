//
//  ChatBubble.swift
//  Dishcover
//
//  Created by OPSolutions on 6/9/24.
//

import SwiftUI

struct ChatBubble: View {
    
    // MARK: - PROPERTIES
    
    var message: String = AppConstants.emptyString
    var isFromSender: Bool = true
    
    var body: some View {
        Text(message)
            .padding(.vertical, 15)
            .padding(.leading, isFromSender ? 20 : 15)
            .padding(.trailing, isFromSender ? 15 : 20)
            .background(isFromSender ? .lightGrayTwo : .customGreen)
            .foregroundStyle(isFromSender ? .customBlack : .customWhite)
            .clipShape(BubbleShape(isFromSender: isFromSender))
            .frame(maxWidth: .infinity, alignment: isFromSender ? .leading : .trailing)
            .padding(.leading, isFromSender ? 0 : 80)
            .padding(.trailing, isFromSender ? 80 : 0)
    }
}

#Preview {
    ChatBubble()
}
