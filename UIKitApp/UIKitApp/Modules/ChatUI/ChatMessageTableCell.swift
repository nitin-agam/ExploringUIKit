//
//  ChatMessageTableCell.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 27/06/23.
//

import UIKit

class ChatMessageTableCell: BaseTableCell {
    
    private let messageLabel = UILabel(font: .systemFont(ofSize: 17), lines: 0)
    private let bubbleBackgroundView = UIView()
    private var leadingConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    private let textMargin: CGFloat = 12
    
    var chatMessage: ChatMessage? {
        didSet {
            guard let chatMessage = chatMessage else { return }
            bubbleBackgroundView.backgroundColor = chatMessage.isIncoming ? .whatsAppReceivedMessage : .whatsAppSentMessage
            messageLabel.textColor = .label
            
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineSpacing = 6
            let attributedString = NSAttributedString(string: chatMessage.text,
                                                      attributes: [.paragraphStyle: paragraph])
            messageLabel.attributedText = attributedString
            
            if chatMessage.isIncoming {
                leadingConstraint?.isActive = true
                trailingConstraint?.isActive = false
            } else {
                leadingConstraint?.isActive = false
                trailingConstraint?.isActive = true
            }
        }
    }
    
    override func initialSetup() {
        super.initialSetup()
        
        bubbleBackgroundView.backgroundColor = .yellow
        bubbleBackgroundView.layer.cornerRadius = 12
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(bubbleBackgroundView, messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: textMargin),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(2 * textMargin)),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -textMargin),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -textMargin),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: textMargin),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: textMargin),
        ])
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint?.isActive = false
        
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint?.isActive = true
    }
}
