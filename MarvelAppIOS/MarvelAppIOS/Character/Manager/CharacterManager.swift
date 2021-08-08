//
//  CharacterManager.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 08/08/21.
//

import Foundation
import ObjectMapper

extension Notification.Name {
    static let favoriteCharacter = Notification.Name("favoriteCharacter")
}

class CharacterManager {
    
    private static var _shared: CharacterManager?
    public static var shared: CharacterManager {
        get {
            if _shared == nil {
                _shared = CharacterManager()
            }
            return _shared!
        }
    }
    
    private let FAVORITES_KEY = "marvel_character_favorites"
    
    func saveFavorite(character: Character) {
        var favorites = getFavorites()
        if !isFavorite(character: character) {
            favorites.append(character)
        }
        else {
            favorites.removeAll { $0.id == character.id }
        }
        updateFavorites(characters: favorites)
        
        NotificationCenter.default.post(name: .favoriteCharacter, object: character)
    }
    
    func getFavorites() -> [Character] {
        let jsonString = UserDefaults.standard.string(forKey: FAVORITES_KEY)
        if let data = jsonString?.data(using: .utf8, allowLossyConversion: false) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                return Mapper<Character>().mapArray(JSONObject: json) ?? []
            }
            catch {
                return []
            }
        }
        return []
    }
    
    func updateFavorites(characters: [Character]) {
        let json = characters.toJSONString(prettyPrint: true)
        UserDefaults.standard.setValue(json, forKey: FAVORITES_KEY)
        UserDefaults.standard.synchronize()
    }
    
    func isFavorite(character: Character) -> Bool {
        let favorites = getFavorites()
        return favorites.contains(where: { $0.id == character.id })
    }
}
