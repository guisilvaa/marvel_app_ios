//
//  KakoError.swift
//  Kako
//
//  Created by Guilherme Silva on 05/03/21.
//

import ObjectMapper

public class KakoError: Mappable, Error {
    
    public var code: String?
    
    public var description: String?
    
    public var userMessage: String?
    
    public init(code: String, description: String, userMessage: String) {
        self.code = code
        self.description = description
        self.userMessage = userMessage
    }
    
    public init(error: KakoErrorType) {
        self.code = error.rawValue
        self.description = error.description()
    }
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        code <- map["code"]
        description <- map["description"]
        userMessage <- map["userMessage"]
    }
}
