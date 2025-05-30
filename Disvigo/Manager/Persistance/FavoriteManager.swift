//
//  FavoriteManager.swift
//  Disvigo
//
//  Created by abdullah on 30.05.2025.
//

import Foundation
import SwiftData
import WidgetKit

@MainActor
@Observable
class FavoriteManager: NSObject {
    var savedLocations: [SavedLocation] = []
    var savedMemories: [SavedMemory] = []
    var savedCities: [SavedCity] = []
    var savedFood: [SavedFood] = []
    
    var modelContext: ModelContext?
    var modelContainer: ModelContainer?
    
    @MainActor
    override init() {
        super.init()
        
        do {
            let container = try ModelContainer(for: SavedLocation.self, SavedMemory.self, SavedCity.self, SavedFood.self)
            modelContainer = container
            modelContext = container.mainContext
            modelContext?.autosaveEnabled = true
            fetchAllFavorites()
                    
        } catch {
            print("Error initializing model container: \(error.localizedDescription)")
        }
    }
    
    private func fetchAllFavorites() {
        guard let context = modelContext else {
            print("Model context is nil.")
            return
        }
        
        do {
            let locationDescriptor = FetchDescriptor<SavedLocation>(sortBy: [.init(\.dateSaved, order: .reverse)])
            savedLocations = try context.fetch(locationDescriptor)
            
            let memoryDescriptor = FetchDescriptor<SavedMemory>(sortBy: [.init(\.dateSaved, order: .reverse)])
            savedMemories = try context.fetch(memoryDescriptor)
            
            let cityDescriptor = FetchDescriptor<SavedCity>(sortBy: [.init(\.dateSaved, order: .reverse)])
            savedCities = try context.fetch(cityDescriptor)
            
            let foodDescriptor = FetchDescriptor<SavedFood>(sortBy: [.init(\.dateSaved, order: .reverse)])
            savedFood = try context.fetch(foodDescriptor)
            
        } catch {
            print("Failed to load favorites: \(error.localizedDescription)")
        }
    }
    
    private func isFavorite<T: Equatable, S>(item: T, in savedItems: [S], keyPath: KeyPath<S, T>) -> Bool {
        return savedItems.contains { $0[keyPath: keyPath] == item }
    }
    
    private func addFavorite<T>(_ savedItem: T) where T: PersistentModel {
        guard let context = modelContext else { return }
        
        context.insert(savedItem)
        saveContext()
    }
    
    private func removeFavorite<T, S>(item: T, from savedItems: [S], keyPath: KeyPath<S, T>) where T: Equatable, S: PersistentModel {
        guard let context = modelContext else { return }
        guard let savedItem = savedItems.first(where: { $0[keyPath: keyPath] == item }) else { return }
        
        context.delete(savedItem)
        saveContext()
    }
    
    func isLocationFavorite(_ location: Location) -> Bool {
        return isFavorite(item: location.id, in: savedLocations, keyPath: \.id)
    }
    
    func addLocationFavorite(_ location: Location) {
        guard !isLocationFavorite(location) else { return }
        let savedLocation = SavedLocation(from: location)
        addFavorite(savedLocation)
    }
    
    func removeLocationFavorite(_ location: Location) {
        removeFavorite(item: location.id, from: savedLocations, keyPath: \.id)
    }
    
    func toggleLocationFavorite(_ location: Location) {
        if isLocationFavorite(location) {
            removeLocationFavorite(location)
        } else {
            addLocationFavorite(location)
        }
    }
    
    func isMemoryFavorite(_ memory: Memory) -> Bool {
        return isFavorite(item: memory.id, in: savedMemories, keyPath: \.id)
    }
    
    func addMemoryFavorite(_ memory: Memory) {
        guard !isMemoryFavorite(memory) else { return }
        let savedMemory = SavedMemory(from: memory)
        addFavorite(savedMemory)
    }
    
    func removeMemoryFavorite(_ memory: Memory) {
        removeFavorite(item: memory.id, from: savedMemories, keyPath: \.id)
    }
    
    func toggleMemoryFavorite(_ memory: Memory) {
        if isMemoryFavorite(memory) {
            removeMemoryFavorite(memory)
        } else {
            addMemoryFavorite(memory)
        }
    }
    
    func isCityFavorite(_ city: City) -> Bool {
        return isFavorite(item: city.id, in: savedCities, keyPath: \.id)
    }
    
    func addCityFavorite(_ city: City) {
        guard !isCityFavorite(city) else { return }
        let savedCity = SavedCity(from: city)
        addFavorite(savedCity)
    }
    
    func removeCityFavorite(_ city: City) {
        removeFavorite(item: city.id, from: savedCities, keyPath: \.id)
    }
    
    func toggleCityFavorite(_ city: City) {
        print("Favoriye eklendi: \(city.name)")
        
        if isCityFavorite(city) {
            removeCityFavorite(city)
        } else {
            addCityFavorite(city)
        }
    }
    
    func isFoodFavorite(_ food: Food) -> Bool {
        return isFavorite(item: food.id, in: savedFood, keyPath: \.id)
    }

    func addFoodFavorite(_ food: Food) {
        guard !isFoodFavorite(food) else { return }
        let saved = SavedFood(from: food)
        addFavorite(saved)
    }

    func removeFoodFavorite(_ food: Food) {
        removeFavorite(item: food.id, from: savedFood, keyPath: \.id)
    }

    func toggleFoodFavorite(_ food: Food) {
        if isFoodFavorite(food) {
            removeFoodFavorite(food)
        } else {
            addFoodFavorite(food)
        }
    }
    
    private func saveContext() {
        guard let context = modelContext else { return }
        
        do {
            try context.save()
            fetchAllFavorites()
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
    }
}
