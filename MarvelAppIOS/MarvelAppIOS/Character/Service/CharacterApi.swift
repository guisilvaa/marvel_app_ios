//
//  CharacterApi.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 05/08/21.
//

import Foundation
import Moya

enum CharacterApi {
    case characters(page: Int, filter: String?)
    case characterDetails(characterId: Int)
}

extension CharacterApi: TargetType {
    
    var baseURL: URL { return URL(string: MarvelApi.shared.domainUrl)! }
    
    var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        case .characterDetails(characterId: let characterId):
            return "/v1/public/characters/\(characterId)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]? {
        
        switch self {
        
        case .characters(page: let page, filter: let query):
            var params = MarvelApi.shared.authParams
            params.updateValue("\(page)", forKey: "offset")
            
            if let query = query, !query.isEmpty {
                params.updateValue(query, forKey: "nameStartsWith")
            }
            
            return params
            
        case .characterDetails:
            return MarvelApi.shared.authParams
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var task: Task {
        return Task.requestParameters(parameters: self.parameters ?? [:], encoding: URLEncoding.queryString)
    }
    
    var sampleData: Data {
        switch self {
        case .characters(page: _, filter: let filter):
            if let _ = filter {
                if let path = Bundle.main.url(forResource: "characters_empty", withExtension: "json") {
                    return try! Data(contentsOf: path)
                }
            }
            else {
                if let path = Bundle.main.url(forResource: "characters", withExtension: "json") {
                    return try! Data(contentsOf: path)
                }
            }
            
            return Data()
        default:
            return Data()
        }
    }
}
