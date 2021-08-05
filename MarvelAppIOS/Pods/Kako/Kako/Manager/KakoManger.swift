//
//  KakoManger.swift
//  Kako
//
//  Created by Guilherme Silva on 11/03/21.
//

import Foundation
import Moya

public protocol KakoManagerDataSource {
    
    func accessToken() -> String
    
    func customHeaders() -> [String:String]?
}

public class KakoManager {
    
    private static var _shared: KakoManager?
    public static var shared: KakoManager {
        get {
            if _shared == nil {
                _shared = KakoManager()
            }
            return _shared!
        }
    }
    
    var dataSource: KakoManagerDataSource!
    
    public func setup(dataSource: KakoManagerDataSource) {
        self.dataSource = dataSource
    }
}
