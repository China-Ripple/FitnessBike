//
//  ServiceApi.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/2.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class ServiceApi: NSObject {
    
   static var host:String = "http://wx.rongtai-china.com/fitnessbike"
    
   //   static var host:String = "http://oraykof.xicp.net/fitnessbike"
    
    internal class func getNotFoundUrl()->String{
        return "\(host)/notfound"
    }
    
    internal class func getAllRankingUrl(maxId:Int,num:Int) -> String {
        
        
        
        return "\(host)/friendsranking?maxId=\(maxId)&num=\(num)"
        
     
    }
    internal class func getSignUpUrl()->String{

        return "\(host)/signup"
        
       //return "http://192.168.0.105:8080/iBreast/servlet/Schedule?account=aaaaaa"
    }
    
    internal class func getExercise(uid:String)->String{
        return "\(host)/exercise?uid=\(uid)"
    }
    
    internal class func getSigninUrl(account:String,password:String)->String{
        
        return "\(host)/signin?account=\(account)&password=\(password)"
    }
    internal class func getWeeklyMiles(account:String)->String{
        
        return "\(host)/weeklymile?account=\(account)"
    }
    
    internal class func getWeeklyCalories(account:String)->String{
        
        return "\(host)/weeklycalorie?account=\(account)"
    }
   
    internal class func getCompMsgUrl(maxId:Int,num:Int)->String{
        
        return "\(host)/compmsg?maxId=\(maxId)/num=\(num)"
        
        
    }
    internal class func getNearbyPeopleUrl(maxId:Int,num:Int)->String{
        
        return "\(host)/nearbypeople?maxId=\(maxId)/num=\(num)"
        
        
    }
    internal class func getTalentUrl(maxId:Int,num:Int)->String{
        
        return "\(host)/talent?maxId=\(maxId)/num=\(num)"
        
        
    }
    internal class func getRegulationUrl(account:String,name:String)->String{
        
        return "\(host)/regulation?id=\(account)/name=\(name)"
        
        
    }
    internal class func getMakeFriendsUrl(account:String)->String{
        
        return "\(host)/makefriends?id=\(account))"
        
        
    }
    internal class func getMsgResponseUrl()->String{
        
        return "\(host)/msgresponse"
    }
    
    internal class func getCompetitionUrl(defenderid:String,type:Int,time:String)->String{
       return "\(host)/msgcompitition?defenderid=\(defenderid)&type=\(type)&tiem=\(time)"
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
