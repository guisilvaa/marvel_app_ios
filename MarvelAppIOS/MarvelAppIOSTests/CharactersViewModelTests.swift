//
//  CharactersViewModelTests.swift
//  MarvelAppIOSTests
//
//  Created by Guilherme Silva on 09/08/21.
//

import XCTest
@testable import MarvelAppIOS
@testable import Kako

class CharactersViewModelTests: XCTestCase {

    var viewModel: CharactersViewModel!
    var mockCharacterService: MockCharactersService!
    
    override func setUp() {
        super.setUp()
        
        self.mockCharacterService = MockCharactersService()
        self.viewModel = .init(charactersService: mockCharacterService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockCharacterService = nil
        
        super.tearDown()
    }
    
    func testCharactersLoadedSuccess() {
        let dataWrapper = CharacterDataWrapper()
        let dataContainer = CharacterDataContainer()
        dataContainer.results = [Character(), Character()]
        dataWrapper.data = dataContainer
        
        mockCharacterService.charactersResult = .success(dataWrapper)
        
        self.viewModel.loadCharacters()
        
        XCTAssertFalse(viewModel.characters.isEmpty)
        XCTAssertNil(viewModel.error)
    }
    
    func testCharactersLoadedSuccessWithEmptyCharacters() {
        let dataWrapper = CharacterDataWrapper()
        let dataContainer = CharacterDataContainer()
        dataContainer.results = []
        dataWrapper.data = dataContainer
        
        mockCharacterService.charactersResult = .success(dataWrapper)
        
        self.viewModel.loadCharacters()
        
        XCTAssertTrue(viewModel.characters.isEmpty)
        XCTAssertNil(viewModel.error)
    }
    
    func testCharactersLoadedWithError() {
        mockCharacterService.charactersResult = .failure(KakoError(code: "", description: "", userMessage: ""))
        
        self.viewModel.loadCharacters()
        
        XCTAssertTrue(viewModel.characters.isEmpty)
        XCTAssertNotNil(viewModel.error)
    }
}
