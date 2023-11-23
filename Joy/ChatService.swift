//
//  ChatService.swift
//  Joy
//
//  Created by Blair Myers on 11/16/23.
//

import Foundation

class ChatService {
    static let shared = ChatService()

    private let session: URLSession
    private let apiKey = "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"
    private let apiURL = URL(string: "https://api.openai.com/v1/assistants/asst_etVzdA26g3Q5uf6nCcn40Zr5")!

    private init() {
        self.session = URLSession(configuration: .default)
    }

    func sendMessage(_ chatMessage: ChatMessage, completion: @escaping (String?) -> Void) {
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("assistants=v1", forHTTPHeaderField: "OpenAI-Beta")

        let requestBody = [
            "model": "gpt-3.5-turbo-16k",
        ] as [String : Any]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            request.httpBody = jsonData
        } catch {
            completion("Error encoding request: \(error)")
            return
        }

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion("Network error: \(error.localizedDescription)")
                return
            }

            if let data = data, let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                if let rawResponse = String(data: data, encoding: .utf8) {
                    print("Raw Response: \(rawResponse)")
                }

                if let choices = jsonResponse["choices"] as? [[String: Any]], let firstChoice = choices.first {
                    let botResponse = firstChoice["message"] as? String ?? "No response"
                    completion(botResponse)
                } else {
                    completion("No valid response found in JSON")
                }
            } else {
                completion("Error parsing JSON response")
            }
        }

        task.resume()
    }
}
