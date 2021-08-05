//
//  MarvelApi.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 05/08/21.
//

import Foundation

class MarvelApi {
    private static var _shared: MarvelApi?
    public static var shared: MarvelApi {
        get {
            if _shared == nil {
                _shared = MarvelApi()
            }
            return _shared!
        }
    }
    
    var domainUrl: String
    private var privatekey: String
    private var apikey: String
    private var ts: String { Date().timeIntervalSince1970.description }
    
    var hash: String  { "\(ts)\(privatekey)\(apikey)".md5 }
    var authParams: [String: String] {
        ["apikey": apikey,
         "ts": ts,
         "hash": hash]
    }
    
    init() {
        domainUrl = "http://gateway.marvel.com"
        privatekey = "25500ebad3d6cd8cb798dc572683fd420a19ee4c"
        apikey = "e480b2ae6af35844f163396c76701722"
    }
}
