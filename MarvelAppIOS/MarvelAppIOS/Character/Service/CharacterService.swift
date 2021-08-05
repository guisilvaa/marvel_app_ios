//
//  CharacterService.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 05/08/21.
//

import Foundation
import Kako

class CharacterService {
    
    private let provider: KakoProvider<CharacterApi>
    
    private static var _shared: CharacterService?
    public static var shared: CharacterService {
        get {
            if _shared == nil {
                _shared = CharacterService()
            }
            return _shared!
        }
    }
    
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
