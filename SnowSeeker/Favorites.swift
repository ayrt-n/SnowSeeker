//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Ayrton Parkinson on 2024/08/10.
//

import Foundation

@Observable
class Favorites {
    private var resorts: Set<String>
    private let key = "Favorites"
    
    init() {
        // Stuff
        
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // Stuff
    }
}
