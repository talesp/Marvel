//
//  String.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 20/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

extension String {
    // Base sample code from: http://iosdeveloperzone.com/2014/10/03/using-commoncrypto-in-swift/
    func md5() -> String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, self, CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate()
        var hexString = ""
        for byte in digest {
            hexString += String(format: "%02x", byte)
        }
        return hexString
    }
}
