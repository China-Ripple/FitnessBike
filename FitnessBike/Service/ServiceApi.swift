//
//  ServiceApi.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/2.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class ServiceApi: NSObject {
    
   //static var host:String = "http://wx.rongtai-china.com/fitnessbike"
    
     static var host:String = "http://oraykof.xicp.net/fitnessbike"
    
    internal class func getNotFoundUrl()->String{
        return "\(host)/notfound"
    }
    
    internal class func getAllRankingUrl(maxId:Int,count:Int) -> String {
        
        //return "\(host)/api/allraking/\(maxId)/\(count)"
        
        return  "\(host)"
    }
    internal class func getSignUpUrl()->String{
      //  return "http://wx.rongtai-china.com/game/timeshift/res/man.png"
        //
        return "\(host)/signup"
        
       
    }
    
    internal class func getSigninUrl(account:String,password:String)->String{
        
        
        
        return "\(host)/signin?account=\(account)&password=\(password)"
        //return "http://121.41.121.9:80/fitnessbike/signup"
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
