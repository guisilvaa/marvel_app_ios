//
//  CharactersViewModel.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 06/08/21.
//

import Foundation
import Kako

protocol CharactersViewModelDelegate {
    func showLoading(show: Bool)
    
    func onCharactersLoaded()
    
    func onCharactersError(error: KakoError?)
}

class CharactersViewModel {
    
    var characters: [Character] = []
    var error: KakoError?
    
    var hasMoreCharacters: Bool { self.characters.count < totalResults }
    
    var hasError: Bool { self.error != nil }
    
    var delegate: CharactersViewModelDelegate?
    
    private var currentPage = 0
    private var totalResults = 0
    
    private var charactersService: CharacterService
    
    init(charactersService: CharacterService = CharacterService()) {
        self.charactersService = charactersService
    }
    
    func loadCharacters(query: String? = nil, showLoading: Bool = true, resetList: Bool = false) {
        self.delegate?.showLoading(show: showLoading)
        
        if resetList {
            self.currentPage = 0
        }
        
        self.charactersService.characters(page: self.currentPage * 20, query: query) { result in
            
            self.delegate?.showLoading(show: false)
            
            switch result {
            case .success(let characters):
                
                let items = characters.data?.results ?? []
                let append = self.currentPage > 0
                
                self.totalResults = characters.data?.total ?? 0
                
                if append {
                    self.characters.append(contentsOf: items)
                }
                else {
                    self.characters = items
                }
                self.error = nil
                self.delegate?.onCharactersLoaded()
                
                self.currentPage += 1
                
            case .failure(let error):
                self.characters = []
                self.error = error
                self.delegate?.onCharactersError(error: error)
            }
        }
    }
    
    func saveFavorite(character: Character) {
        CharacterManager.shared.saveFavorite(character: character)
    }
    
    func isFavorite(character: Character) -> Bool {
        return CharacterManager.shared.isFavorite(character: character)
    }
}
