//
//  VisitedManager.swift
//  Disvigo
//
//  Created by abdullah on 31.05.2025.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class VisitedManager: NSObject {
    var visitedLists: [VisitedList] = []
    var modelContext: ModelContext?
    var modelContainer: ModelContainer?
    
    @MainActor
    override init() {
        super.init()
        do {
            let container = try ModelContainer(for: VisitedList.self, VisitedListItem.self)
            modelContainer = container
            modelContext = container.mainContext
            modelContext?.autosaveEnabled = true
            fetchLists()
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func fetchLists() {
        guard let context = modelContext else { return }
        do {
            let descriptor = FetchDescriptor<VisitedList>(sortBy: [.init(\.addedDate, order: .reverse)])
            visitedLists = try context.fetch(descriptor)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func createList(name: String, symbolName: String, color: Color) -> (Bool, String) {
        guard let context = modelContext else { return (false, String(localized: "System error")) }
            
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty { return (false, String(localized: "List name cannot be empty")) }
            
        let exists = visitedLists.contains { $0.name.lowercased() == trimmed.lowercased() }
        if exists { return (false, String(localized: "A list with this name already exists")) }
            
        let newList = VisitedList(name: trimmed, symbolName: symbolName, color: color)
        context.insert(newList)
        save()
        return (true, String(localized: "List created successfully"))
    }
    
    func updateList(_ list: VisitedList, name: String, symbolName: String, color: Color) -> (Bool, String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty { return (false, String(localized: "List name cannot be empty")) }
        
        if list.name != trimmed {
            let exists = visitedLists.contains { $0.name.lowercased() == trimmed.lowercased() && $0.id != list.id }
            if exists { return (false, String(localized: "A list with this name already exists")) }
        }
        
        list.name = trimmed
        list.symbolName = symbolName
        list.colorHex = color.toHex() ?? list.colorHex
        save()
        return (true, String(localized: "List updated successfully"))
    }
    
    func deleteList(_ list: VisitedList) {
        guard let context = modelContext else { return }
        context.delete(list)
        save()
    }
    
    func getVisitedList(by id: UUID) -> VisitedList? {
        guard let context = modelContext else { return nil }
         
        do {
            let descriptor = FetchDescriptor<VisitedList>(
                predicate: #Predicate { $0.id == id }
            )
            return try context.fetch(descriptor).first
        } catch {
            print("Error fetching list: \(error)")
            return nil
        }
    }
    
    private func save() {
        guard let context = modelContext else { return }
        do {
            try context.save()
            fetchLists()
        } catch {
            print("Error: \(error)")
        }
    }
}
