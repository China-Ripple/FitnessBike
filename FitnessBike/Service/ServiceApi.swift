//
//  ServiceApi.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/2.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class ServiceApi: NSObject {
    
    static var host:String = "http://121.41.121.9:8888"
    //"http://demo.swiftmi.com"
    
    internal class func getAllRankingUrl(maxId:Int,count:Int) -> String {
        
        //return "\(host)/api/allraking/\(maxId)/\(count)"
        
        return  "\(host)"
    }
    
//    
//    class func getLoginUrl()->String {
//        var url = "\(host)/api/user/login"
//        return url;
//    }
//    
//    class func getRegistUrl() -> String {
//        
//        var url = "\(host)/api/user/reg"
//        return url;
//    }
//    class func getTopicCommentUrl() -> String {
//        
//        var url = "\(host)/api/topic/comment"
//        return url;
//    }
//    
//    class func getCreateTopicUrl() -> String {
//        
//        var url = "\(host)/api/topic/create"
//        return url;
//    }

}
