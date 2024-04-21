//
//  DateTimeService.swift
//  FoodGrab
//
//  Created by j8bok on 4/6/24.
//

import Foundation

struct DateTimeService {
    static func getFormattedDateTime() -> String {
        let timestamp = Date().timeIntervalSince1970
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
      
        let date = Date(timeIntervalSince1970: timestamp)
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}
