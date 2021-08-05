//
//  KakoErrorType.swift
//  Kako
//
//  Created by Guilherme Silva on 05/03/21.
//

import Foundation

public enum KakoErrorType: String {
    
    case connection = "NO_CONNECTION"
    case parse = "PARSE_RESPONSE"
    case unauthorized = "UNAUTHORIZED"
    case timeout = "TIMEOUT"
    case unknown = "UNKNOWN"
    case invalidAppVersion = "INVALID_APP_VERSION"
    
    func description() -> String {
        switch self {
        case .connection:
            return "No internet connection"
        case .parse:
            return "Fail to parse response"
        case .unauthorized:
            return "Fail to refresh token"
        case .timeout:
            return "Request time out"
        case .unknown:
            return "Unknown error"
        case .invalidAppVersion:
            return "Invalid app version"
        }
    }
}
