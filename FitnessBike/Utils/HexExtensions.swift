//
//  HexExtensions.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/15.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import Base32
import Foundation

extension String {
    public var hexDecodedData: NSData {
        return base16DecodeToData(self)!
    }
}

extension NSData {
    public var hexEncodedString: String {
        return base16Encode(self, uppercase: false)
    }
    
    public class func randomOfLength(length: UInt) -> NSData? {
        let length = Int(length)
        if let data = NSMutableData(length: length) {
            _ = SecRandomCopyBytes(kSecRandomDefault, length, UnsafeMutablePointer<UInt8>(data.mutableBytes))
            return NSData(data: data)
        } else {
            return nil
        }
    }
}

extension NSData {
    public var base64EncodedString: String {
        return base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
    }
}
