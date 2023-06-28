//
//  Int+Extension.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 22/06/23.
//

import Foundation

extension Int {
    
    // Converting the Int value in string format. Eg. 1234 -> 1.2K
    var formatWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million * 10) / 10)M"
        } else if thousand >= 1.0 {
            return "\(round(thousand * 10) / 10)K"
        }
        
        return "\(self)"
    }
}
