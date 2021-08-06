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
    
    private var currentPage = 0
    private var totalResults = 0
    
    var hasMoreCharacters: Bool { self.characters.count < totalResults }
    
    var delegate: CharactersViewModelDelegate!
    
    func loadCharacters(query: String? = nil, isRefreshing: Bool = false) {
        if isRefreshing || query != nil {
            self.currentPage = 0
        }
        
        if !isRefreshing && self.currentPage == 0 {
            self.delegate.showLoading(show: true)
        }
        
        CharacterService.shared.characters(page: self.currentPage * 20, query: query) { result in
            
            self.delegate.showLoading(show: false)
            
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
                self.delegate.onCharactersLoaded()
                
                self.currentPage += 1
                
            case .failure(let error):
                self.characters = []
                self.delegate.onCharactersError(error: error)
            }
        }
    }
}
