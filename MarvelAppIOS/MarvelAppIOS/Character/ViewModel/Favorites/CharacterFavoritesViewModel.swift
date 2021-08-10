//
//  CharacterFavoritesViewModel.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 08/08/21.
//

import Foundation

protocol CharacterFavoriteViewModelDelegate {
    func onFavoritesLoaded()
}

class CharacterFavoritesViewModel {
    
    var favorites: [Character] = []
    var delegate: CharacterFavoriteViewModelDelegate!
    
    func loadFavorites() {
        self.favorites = CharacterManager.shared.getFavorites()
        self.delegate.onFavoritesLoaded()
    }
    
    func deleteFavorite(character: Character) {
        CharacterManager.shared.saveFavorite(character: character)
    }
}
