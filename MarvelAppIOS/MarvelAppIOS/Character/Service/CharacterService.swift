//
//  CharacterService.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 05/08/21.
//

import Foundation
import Kako
import Moya

protocol CharacterServiceProtocol {
    func characters(page: Int, query: String?, completionHandler: @escaping (Result<CharacterDataWrapper, KakoError>) -> Void)
}

class CharacterService: CharacterServiceProtocol {
    
    private var provider: KakoProvider<CharacterApi>
    
    init(provider: KakoProvider<CharacterApi> = KakoProvider<CharacterApi>(stubClosure: MoyaProvider.neverStub)) {
        self.provider = provider
    }
    
    func characters(page: Int, query: String? = nil, completionHandler: @escaping (Result<CharacterDataWrapper, KakoError>) -> Void) {
        provider.requestObject(target: .characters(page: page, filter: query), completionHandler: completionHandler)
    }
    
    func characterDetails(characterId: Int, completionHandler: @escaping (Result<CharacterDataWrapper, KakoError>) -> Void) {
        provider.requestObject(target: .characterDetails(characterId: characterId), completionHandler: completionHandler)
    }
}
