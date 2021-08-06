//
//  KakoHandler.swift
//  Tmdb
//
//  Created by Guilherme Silva on 18/03/21.
//

import Foundation
import Kako

class KakoHandler: KakoManagerDataSource {
    
    func accessToken() -> String {
        return ""
    }
    
    func customHeaders() -> [String : String]? {
        return nil
    }
    
    
    
}
