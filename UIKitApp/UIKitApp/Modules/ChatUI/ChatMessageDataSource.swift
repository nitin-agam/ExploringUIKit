//
//  ChatMessageDataSource.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 27/06/23.
//

import Foundation

class ChatMessageDataSource {
    
    private var messages = [
        ChatMessage(text: "How are you, Maria?", isIncoming: false, date:  "01/06/2023".asDate()),
        ChatMessage(text: "I am fine, what about you?", isIncoming: true, date:  "01/06/2023".asDate()),
        ChatMessage(text: "I am also fine, how are your studies going on?", isIncoming: false, date: "1/06/2023".asDate()),
        ChatMessage(text: "My studies are going well. You know that due to the pandemic classes are being conducted online.", isIncoming: true, date: "1/06/2023".asDate()),
        ChatMessage(text: "Yes, I am also studying through online classes.", isIncoming: false, date: "1/06/2023".asDate()),
        ChatMessage(text: "Have you realised that the classes are more enticing with the new ways of teaching? Our teachers have also become more creative with their approaches.", isIncoming: true, date: "03/06/2023".asDate()),
        ChatMessage(text: "I have seen that too. These online classes are very good for all of us. We learn something new every day even though there’s a pandemic.", isIncoming: false, date: "03/06/2023".asDate()),
        ChatMessage(text: "But I have some problems too with online classes.", isIncoming: true, date: "09/06/2023".asDate()),
        ChatMessage(text: "What problems are you facing during online classes?", isIncoming: false, date: "10/06/2023".asDate()),
        ChatMessage(text: "Even though I enjoy online classes. But I lost that concern at which we study in our class.", isIncoming: true, date: "10/06/2023".asDate()),
        ChatMessage(text: "Yes you are right, Some students lose focus if the teacher doesn’t look after them.", isIncoming: false, date: "10/06/2023".asDate()),
        ChatMessage(text: "Sure no problem, goodbye 😍😎", isIncoming: false, date: "10/06/2023".asDate()),
        ChatMessage(text: "Goodbye, it was nice talking to you.", isIncoming: true, date: "10/06/2023".asDate()),
        ChatMessage(text: "Same here, see you soon !!", isIncoming: false, date: "10/06/2023".asDate())
    ]
    
    var messageGroups: [[ChatMessage]] = []
    
    
    // grouping our messages inside this Dictionary, and returning data - (by DATE )
    func groupMessagesByDate() {
        
        let groupedMessages = Dictionary(grouping: messages) { element in
            element.date
        }
        
        // provide a sorting for your keys somehow
        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach { key in
            if let value = groupedMessages[key] {
                messageGroups.append(value)
            }
        }
    }
}

struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}
