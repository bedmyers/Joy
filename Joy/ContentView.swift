//
//  ContentView.swift
//  Joy
//
//  Created by Blair Myers on 11/16/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ChatViewModel()

    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages, id: \.content) { message in
                    HStack {
                        if message.role == "bot" {
                            Spacer()
                        }
                        let _ = print(message.content)
                        Text(message.content)
                            .padding()
                            .background(message.role == "user" ? Color.blue : Color.gray)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                        if message.role == "user" {
                            Spacer()
                        }
                    }
                }
            }

            HStack {
                TextField("Type your message", text: $viewModel.userMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Send") {
                    viewModel.sendMessage()
                }
                .disabled(viewModel.userMessage.isEmpty)
            }
            .padding()
        }
    }
}
