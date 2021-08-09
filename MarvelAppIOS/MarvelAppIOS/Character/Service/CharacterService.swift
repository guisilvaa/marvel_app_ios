//
//  CharacterService.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 05/08/21.
//

import Foundation
import Kako

protocol CharacterServiceProtocol {
    func characters(page: Int, query: String?, completionHandler: @escaping (Result<CharacterDataWrapper, KakoError>) -> Void)
}

class CharacterService: CharacterServiceProtocol {
    
    private let provider: KakoProvider<CharacterApi>
    
    init() {
        provider = KakoProvider<CharacterApi>()
    }
    
    func characters(page: Int, query: String? = nil, completionHandler: @escaping (Result<CharacterDataWrapper, KakoError>) -> Void) {
        provider.requestObject(target: .characters(page: page, filter: query), completionHandler: completionHandler)
    }
    
    func characterDetails(characterId: Int, completionHandler: @escaping (Result<CharacterDataWrapper, KakoError>) -> Void) {
        provider.requestObject(target: .characterDetails(characterId: characterId), completionHandler: completionHandler)
    }
}
