//
//  String+Extension.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 27/06/23.
//

import Foundation

extension String {
    
    func asDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: self) ?? Date()
    }
}
