//
//  GemineAIManager.swift
//  Disvigo
//
//  Created by abdullah on 27.05.2025.
//

import Foundation
import GoogleGenerativeAI

class GeminiAIManager {
    static let shared = GeminiAIManager()
    
    private let model: GenerativeModel
    
    private init() {
        let apiKey = GemineApiKey.default
        
        model = GenerativeModel(name: "gemini-2.0-flash", apiKey: apiKey)
    }
    
    func sendLocationMessage(textInput: String) async throws -> Message {
        let response = try await model.generateContent(textInput)
        
        guard let response = response.text else {
            return Message(content: "Sorry, I couldn't process your request. Please try again.", isFromUser: false)
        }
        
        return Message(content: response, isFromUser: false)
    }
}
