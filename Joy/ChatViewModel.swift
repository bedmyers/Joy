//
//  ChatViewModel.swift
//  Joy
//
//  Created by Blair Myers on 11/22/23.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var userMessage: String = ""
    @Published var messages: [Message] = []

    func sendMessage() {
        let newMessage = Message(role: "user", content: userMessage)
        messages.append(newMessage)

        ChatService.shared.sendMessage(ChatMessage(messages: [newMessage])) { [weak self] responseContent in
            DispatchQueue.main.async {
                if let content = responseContent {
                    let responseMessage = Message(role: "bot", content: content)
                    self?.messages.append(responseMessage)
                }
                self?.userMessage = ""
            }
        }
    }
}
