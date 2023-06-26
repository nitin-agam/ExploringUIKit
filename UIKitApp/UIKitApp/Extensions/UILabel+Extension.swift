//
//  UILabel+Extension.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 26/06/23.
//

import UIKit

extension UILabel {
    
    convenience init(font: UIFont, text: String? = nil, textColor: UIColor = .label, lines: Int = 1, alignment: NSTextAlignment = .left) {
        self.init(frame: .zero)
        self.font = font
        self.text = text
        self.textColor = textColor
        self.numberOfLines = lines
        self.textAlignment = alignment
    }
}
