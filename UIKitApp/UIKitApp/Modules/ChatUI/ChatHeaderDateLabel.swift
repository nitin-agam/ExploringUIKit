//
//  ChatHeaderDateLabel.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 27/06/23.
//

import UIKit

class ChatHeaderDateLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .label
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        font = .systemFont(ofSize: 16)
        backgroundColor = .whatsAppHeaderBack
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let originalContentSize = super.intrinsicContentSize
        let height = originalContentSize.height + 12
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return CGSize(width: originalContentSize.width + 20, height: height)
    }
}
