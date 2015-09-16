//
//  Bytes.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/15.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import Foundation

public typealias GUID = String

/**
* Utilities for futzing with bytes and such.
*/
public class Bytes {
    
    public class func generateRandomBytes(len: UInt) -> NSData {
        let len = Int(len)
        let data: NSMutableData! = NSMutableData(length: len)
        let bytes = UnsafeMutablePointer<UInt8>(data.mutableBytes)
        let result: Int32 = SecRandomCopyBytes(kSecRandomDefault, len, bytes)
        
        assert(result == 0, "Random byte generation failed.");
        return data
    }
    
    public class func generateGUID() -> GUID {
        // Turns the standard NSData encoding into the URL-safe variant that Sync expects.
        return generateRandomBytes(9)
            .base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
            .stringByReplacingOccurrencesOfString("/", withString: "_", options: NSStringCompareOptions(), range: nil)
            .stringByReplacingOccurrencesOfString("+", withString: "-", options: NSStringCompareOptions(), range: nil)
    }
    
    public class func decodeBase64(b64: String) -> NSData {
        return NSData(base64EncodedString: b64,
            options: NSDataBase64DecodingOptions())!
    }
    
    /**
    * Turn a string of base64 characters into an NSData *without decoding*.
    * This is to allow HMAC to be computed of the raw base64 string.
    */
    public class func dataFromBase64(b64: String) -> NSData? {
        return b64.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
    }
    
    func fromHex(str: String) -> NSData {
        // TODO
        return NSData()
    }
}