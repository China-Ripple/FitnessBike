//
//  User.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/10.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class User: NSObject {

    var account:String = "10001"
    
    
    class var sharedInstance : User {
        struct Static {
            static let instance : User = User()
        }
        return Static.instance
    }
    
    
    
}
