//
//  ResponseModel.swift
//  Joy
//
//  Created by Blair Myers on 11/16/23.
//

import Foundation

struct ChatMessage: Codable {
    var messages: [Message]
}

struct Message: Codable {
    var role: String
    var content: String
}

struct APIResponse: Codable {
    var choices: [Choice]
}

struct Choice: Codable {
    var message: MessageContent
}

struct MessageContent: Codable {
    var content: String
}
