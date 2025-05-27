//
//  ChatViewModel.swift
//  Disvigo
//
//  Created by abdullah on 27.05.2025.
//

import Foundation

enum GemineViewState {
    case location(_ location: Location)
    case turkey
    case city(_ city: City)
}

@Observable
class ChatViewModel {
    var textInput = ""
    var messages: [Message] = []
    var isLoading = false
    var didLoad = true
    var messageCount = 0
    var conversationStartTime = Date()
    
    func sendMessageWith(aiViewState: GemineViewState) {
        guard !textInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let cleanedInput = textInput.trimmingCharacters(in: .whitespacesAndNewlines)
        let userMessage = Message(content: cleanedInput, isFromUser: true)
        
        messages.append(userMessage)
        messageCount += 1
        isLoading = true
        textInput = ""
        
        // Add loading message
        let loadingMessage = Message(content: "", isFromUser: false, isLoading: true)
        messages.append(loadingMessage)
        
        Task {
            await sendAIRequest(userMessage: userMessage, aiViewState: aiViewState)
        }
    }
    
    @MainActor
    private func sendAIRequest(userMessage: Message, aiViewState: GemineViewState) async {
        do {
            let question = buildContextualQuestion(userMessage: userMessage, aiViewState: aiViewState)
            let response = try await GeminiAIManager.shared.sendLocationMessage(textInput: question)
            
            // Remove loading message
            removeLoadingMessage()
            
            // Add AI response
            messages.append(response)
            isLoading = false
            
        } catch {
            handleError(error)
        }
    }
    
    private func buildContextualQuestion(userMessage: Message, aiViewState: GemineViewState) -> String {
        let conversationContext = buildConversationContext()
        let basePrompt = getBasePrompt(for: aiViewState)
        
        return """
        \(basePrompt)
        
        Conversation Context:
        \(conversationContext)
        
        Current Question: \(userMessage.content)
        
        Please provide a helpful, engaging response that:
        1. Directly answers the user's question
        2. Is informative yet conversational
        3. Includes practical tips when relevant
        4. Uses emojis sparingly but effectively
        5. Maintains the established conversation tone
        6. Is concise but complete (2-4 paragraphs max)
        """
    }
    
    private func getBasePrompt(for aiViewState: GemineViewState) -> String {
        switch aiViewState {
        case .location(let location):
            return """
            You are an expert local guide for \(location.title). 
            Location details: \(location.description)
            
            Your role: Provide insider knowledge about this location including:
            - Historical significance and stories
            - Best visiting times and practical tips
            - Hidden gems and local secrets
            - Cultural significance and traditions
            - Photography spots and experiences
            
            Tone: Friendly, knowledgeable, like a passionate local guide.
            """

        case .turkey:
            return """
            You are a comprehensive Turkey travel and culture expert.
            
            Your expertise covers:
            - Turkish history from ancient civilizations to modern times
            - Regional cultures, traditions, and customs
            - Cuisine, including regional specialties
            - Geography, climate, and best travel times
            - Popular and off-the-beaten-path destinations
            - Practical travel advice and local etiquette
            
            Tone: Warm, enthusiastic, culturally aware, like a knowledgeable Turkish friend.
            """
            
        case .city(let city):
            return """
            You are a local city expert for \(city.name).
            
            Your knowledge includes:
            - City neighborhoods and districts
            - Historical landmarks and modern attractions
            - Local food scene and restaurant recommendations
            - Transportation and getting around
            - Cultural events and entertainment
            - Shopping areas and local markets
            - Day trip ideas and nearby attractions
            
            Tone: Urban, savvy, like a longtime resident who loves their city.
            """
        }
    }
    
    private func buildConversationContext() -> String {
        let recentMessages = messages.suffix(6)
        
        if recentMessages.isEmpty {
            return "This is the start of our conversation."
        }
        
        let context = recentMessages.compactMap { message in
            if !message.isLoading {
                let sender = message.isFromUser ? "User" : "Assistant"
                return "\(sender): \(message.content)"
            }
            return nil
        }.joined(separator: "\n")
        
        return context.isEmpty ? "This is the start of our conversation." : context
    }
    
    private func removeLoadingMessage() {
        if let index = messages.firstIndex(where: { $0.isLoading }) {
            messages.remove(at: index)
        }
    }
    
    private func handleError(_ error: Error) {
        removeLoadingMessage()
        
        let errorMessages = [
            String(localized: "I apologize, but I'm having trouble connecting right now. Could you please try asking again?"),
            String(localized: "Oops! Something went wrong on my end. Let's try that question once more."),
            String(localized: "I seem to be experiencing some technical difficulties. Please give me another chance to help you!")
        ]
        
        let randomErrorMessage = errorMessages.randomElement() ?? errorMessages[0]
        let errorMessage = Message(content: randomErrorMessage, isFromUser: false)
        
        messages.append(errorMessage)
        isLoading = false
        
        print("Chat Error: \(error.localizedDescription)")
    }
    
    func welcomeMessage(_ message: String) {
        guard didLoad else { return }
        
        let welcomeMessage = Message(content: message, isFromUser: false)
        messages.append(welcomeMessage)
        didLoad = false
        conversationStartTime = Date()
    }
    
    // MARK: - Analytics & Insights

    var conversationDuration: TimeInterval {
        Date().timeIntervalSince(conversationStartTime)
    }
    
    var userMessageCount: Int {
        messages.filter { $0.isFromUser }.count
    }
    
    var aiMessageCount: Int {
        messages.filter { !$0.isFromUser && !$0.isLoading }.count
    }
}


extension Message {
    var wordCount: Int {
        content.components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .count
    }
    
    var isShort: Bool {
        wordCount <= 10
    }
    
    var isLong: Bool {
        wordCount > 50
    }
}
