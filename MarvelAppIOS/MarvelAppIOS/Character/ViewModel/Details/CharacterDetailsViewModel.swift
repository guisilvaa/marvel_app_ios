//
//  CharacterDetailsViewModel.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 08/08/21.
//

import Foundation

class CharacterDetailViewModel {
    
    var character: Character
    
    var isFavorite: Bool { CharacterManager.shared.isFavorite(character: self.character) }
    
    init(character: Character) {
        self.character = character
    }
    
    func saveFavorite() {
        CharacterManager.shared.saveFavorite(character: self.character)
    }
}
