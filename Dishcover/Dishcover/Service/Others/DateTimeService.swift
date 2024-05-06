//
//  DateTimeService.swift
//  Dishcover
//
//  Created by j8bok on 4/6/24.
//

import Foundation

struct DateTimeService {
    static func getCurrentDateTime() -> String {
        let timestamp = Date().timeIntervalSince1970
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = Date(timeIntervalSince1970: timestamp)
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    static func formatStringDateTime(of dateTime: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        
        guard let formattedDateTime = dateFormatter.date(from: dateTime) else {
            print("Couldn't format date. ⛔")
            return nil
        }
        
        return formattedDateTime
    }
    
    static func computeElapsedDateTime(from date: Date) -> String {
        let currentCalendar = Calendar.current
        let currentDate = Date()
        
        let dateComponents = currentCalendar.dateComponents([.year, .hour, .minute, .second], from: date, to: currentDate)
        
        switch dateComponents {
        case let diff where diff.year ?? 0 > 0:
             let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "MMM d, yyyy"
             return dateFormatter.string(from: date)
            
        case let diff where diff.hour ?? 0 > 24:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"
            return dateFormatter.string(from: date)
            
        case let diff where diff.hour ?? 0 >= 1:
            return "\(diff.hour!)h"
            
        case let diff where diff.minute ?? 0 >= 1:
            return "\(diff.minute!)m"
            
        default:
            return "Just now"
        }
    }
}
