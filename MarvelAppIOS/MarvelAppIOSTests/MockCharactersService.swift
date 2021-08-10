//
//  MockCharactersService.swift
//  MarvelAppIOSTests
//
//  Created by Guilherme Silva on 09/08/21.
//

import Foundation
@testable import MarvelAppIOS
@testable import Kako

final class MockCharactersService: CharacterServiceProtocol {
    
    var charactersResult: Result<CharacterDataWrapper, KakoError> = .success(CharacterDataWrapper())
    
    func characters(page: Int, query: String?, completionHandler: @escaping (Result<CharacterDataWrapper, KakoError>) -> Void) {
        completionHandler(charactersResult)
    }

}
