//
//  TimeIntervalExtension.swift
//  NiestierovNatifeTest
//
//  Created by Denys Niestierov on 22.07.2022.
//

import Foundation

extension TimeInterval {
    func toDateString(dateFormatter: String = "MMM d, HH:mm") -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatter
        formatter.locale = Locale(identifier: "en_US")
        
        let currentTime = formatter.string(from: date as Date)
        
        return currentTime
    }
}
