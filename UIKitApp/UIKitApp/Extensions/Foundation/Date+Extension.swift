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
}
