//
//  StringExtension.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 05/08/21.
//

import Foundation
import CryptoKit

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    var md5: String {
        guard let data = self.data(using: .utf8) else { fatalError("Failed to convert string to data") }
        return Insecure.MD5.hash(data: data).map { String(format: "%02hhx", $0) }.joined()
    }
        
}
