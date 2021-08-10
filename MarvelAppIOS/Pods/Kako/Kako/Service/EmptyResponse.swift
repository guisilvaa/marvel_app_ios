//
//  EmptyResponse.swift
//  Kako
//
//  Created by Guilherme Silva on 05/03/21.
//

import Foundation
import ObjectMapper

public class EmptyResponse: Mappable {
    
    public init() {
        
    }
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
    }
}
