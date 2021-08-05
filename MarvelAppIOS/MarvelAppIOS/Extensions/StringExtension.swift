//
//  StringExtension.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 05/08/21.
//

import Foundation
import CommonCrypto

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    var md5: String {
            let data = Data(self.utf8)
            let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
                var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
                CC_SHA256(bytes.baseAddress, CC_LONG(data.count), &hash)
                return hash
            }
            return hash.map { String(format: "%02x", $0) }.joined()
        }
}
