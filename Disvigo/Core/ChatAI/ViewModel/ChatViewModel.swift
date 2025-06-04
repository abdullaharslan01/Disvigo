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
    case food(_ food: Food)
    case memory(_ memory: Memory)
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
            
            removeLoadingMessage()
            
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
        Respond in the same language as the user's question. \(basePrompt) Previous conversation: \(conversationContext) Current question: \(userMessage.content). Provide a helpful, friendly and practical response. Keep it 2-3 paragraphs.
        """
    }
    
    private func getBasePrompt(for aiViewState: GemineViewState) -> String {
        switch aiViewState {
        case .location(let location):
            let shortDescription = String(location.description.prefix(50))
            return "You are a local guide for \(location.title) in Turkey. Location: \(shortDescription)... Provide info about historical places, tips, hidden gems."

        case .turkey:
            return "You are a Turkey travel expert. Provide info about Turkish history, culture, cuisine, destinations and travel advice within Turkey."
            
        case .city(let city):
            return "You are a city expert for \(city.name), Turkey. Provide info about neighborhoods, places, restaurants, transportation and events in this Turkish city."
            
        case .food(let food):
            let shortDescription = String(food.description.prefix(50))
            return "You are a food expert for \(food.title) in Turkey. Description: \(shortDescription)... Provide info about Turkish local food, restaurants, street food and recipes."
            
        case .memory(let memory):
            let shortDescription = String(memory.description.prefix(50))
            return "You are a shopping expert for \(memory.title) in Turkey. Description: \(shortDescription)... Provide info about Turkish souvenirs, crafts, markets and shopping tips."
        }
    }
    
    private func buildConversationContext() -> String {
        let recentMessages = messages.suffix(4)
        
        if recentMessages.isEmpty {
            return "Start of conversation."
        }
        
        let context = recentMessages.compactMap { message in
            if !message.isLoading {
                let sender = message.isFromUser ? "User" : "Assistant"
                return "\(sender): \(message.content)"
            }
            return nil
        }.joined(separator: "\n")
        
        return context.isEmpty ? "Start of conversation." : context
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
