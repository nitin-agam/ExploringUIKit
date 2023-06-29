//
//  Date+Extension.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 27/06/23.
//

import Foundation

extension Date {
    
    func asString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
    
    func chatCenterDisplayTime() -> String {
        
        let dateString = self.asString()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if let date = dateFormatter.date(from: dateString) {
            if date.isDateInToday { return "Today" }
            if date.timeInDays() == 1 { return "Yesterday" }
            dateFormatter.dateFormat = "d MMMM yyyy"
            return dateFormatter.string(from: date)
        }
        return dateString
    }
    
    func dateOnly() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
    
    var isDateInToday: Bool {
        return Calendar.autoupdatingCurrent.isDateInToday(self)
    }
    
    func timeInDays() -> Int {
        Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
    }
}
