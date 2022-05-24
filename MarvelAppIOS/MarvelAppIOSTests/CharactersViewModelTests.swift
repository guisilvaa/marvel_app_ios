//
//  CharactersViewModelTests.swift
//  MarvelAppIOSTests
//
//  Created by Guilherme Silva on 09/08/21.
//

import XCTest
@testable import MarvelAppIOS
@testable import Kako
@testable import Moya

class CharactersViewModelTests: XCTestCase {

    var viewModel: CharactersViewModel!
    var provider: KakoProvider<CharacterApi>!
    var service: CharacterService!
    
    var expectationCharactersLoading: XCTestExpectation!
    var expectationCharactersLoaded: XCTestExpectation!
    var expectationError: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        
        self.provider = KakoProvider<CharacterApi>(stubClosure: MoyaProvider.immediatelyStub)
        self.service = CharacterService(provider: provider)
        self.viewModel = CharactersViewModel(charactersService: service)
        self.viewModel.delegate = self
        
        expectationCharactersLoading = XCTestExpectation()
        expectationCharactersLoaded = XCTestExpectation()
        expectationError = XCTestExpectation()
    }
    
    override func tearDown() {
        provider = nil
        service = nil
        viewModel = nil
        expectationCharactersLoading = nil
        expectationCharactersLoaded = nil
        expectationError = nil
        
        super.tearDown()
    }
    
    func testCharactersLoadedSuccess() {
        self.viewModel.loadCharacters()
        wait(for: [expectationCharactersLoading, expectationCharactersLoaded], timeout: 1)
        XCTAssertFalse(viewModel.characters.isEmpty)
        XCTAssertNil(viewModel.error)
    }
    
    func testCharactersLoadedSuccessWithEmptyResult() {
        self.viewModel.loadCharacters(query: "empty")
        wait(for: [expectationCharactersLoading, expectationCharactersLoaded], timeout: 1)
        XCTAssertTrue(viewModel.characters.isEmpty)
        XCTAssertNil(viewModel.error)
    }
    
    func testCharactersLoadedWithError() {
        
        
        self.viewModel.loadCharacters()
        
        XCTAssertTrue(viewModel.characters.isEmpty)
        XCTAssertNotNil(viewModel.error)
    }
}

extension CharactersViewModelTests: CharactersViewModelDelegate {
    func showLoading(show: Bool) {
        if show {
            expectationCharactersLoading.fulfill()
        }
    }
    
    func onCharactersLoaded() {
        expectationCharactersLoaded.fulfill()
    }
    
    func onCharactersError(error: KakoError?) {
        expectationError.fulfill()
    }
}
