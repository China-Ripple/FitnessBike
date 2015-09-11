//
//  Router.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/2.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import Alamofire


enum Router: URLRequestConvertible{

    
    static var token: String?
    
    case Exercise(account:String)
    case AllRanking(maxId:Int,num:Int)
    case SignIn(account:String,password:String)
    case SignUp(parameters:[String: AnyObject])
    case WeeklyMiles(account:String)
    case WeeklyCalories(account:String)
    case Competition(defenderid:String,type:Int,time:String)
    case CompMsg(maxId:Int,num:Int)
    case MsgResponse(parameters:[String: AnyObject])
    case NearbyPeople(maxId:Int,num:Int)
    case Talent(maxId:Int,num:Int)
    case Regulation(account:String,name:String)
    case Makefriends(account:String)
    
    var method: Alamofire.Method {
        switch self {
        case .AllRanking:
            return .GET
        case .SignIn:
            return .GET
        case .SignUp:
            return .POST
        case .Exercise:
            return .GET
        case .WeeklyMiles:
            return .GET
        case .WeeklyCalories:
            return .GET
        case .Competition:
            return .GET
        case .CompMsg:
            return .GET
        case .MsgResponse:
            return .POST
        case .NearbyPeople:
            return .GET
        case .Talent:
            return .GET
        case .Regulation:
            return .GET
        case .Makefriends:
            return .GET
        default:
            return .GET
        }
        
    }
    
    
    var path: String {
        switch self {
        case .AllRanking(let maxId,let num):
            return ServiceApi.getAllRankingUrl(maxId,num:num)
        case .SignIn(let account, let password):
            return  ServiceApi.getSigninUrl(account, password:password)
        case .SignUp:
            return ServiceApi.getSignUpUrl()
        case .WeeklyMiles(let account):
            return ServiceApi.getWeeklyMiles(account)
       case .Exercise(let account):
            return ServiceApi.getExercise(account)
        case .WeeklyCalories(let account):
            return ServiceApi.getWeeklyCalories(account)
        case .Competition(let defenderid,let type, let time):
            return ServiceApi.getCompetitionUrl(defenderid,type: type,time: time)
        case .CompMsg(let maxId,let num):
            return ServiceApi.getCompMsgUrl(maxId,num:num)
        case .MsgResponse:
            return ServiceApi.getMsgResponseUrl()
         case .NearbyPeople(let maxId,let num):
            return ServiceApi.getNearbyPeopleUrl(maxId,num:num)
        case Talent(let maxId,let num):
            return ServiceApi.getTalentUrl(maxId,num: num)
        case Regulation(let account, let name):
            return ServiceApi.getRegulationUrl(account, name: name)
        case Makefriends(let account):
            return ServiceApi.getMakeFriendsUrl(account)
        default:
            return ServiceApi.getNotFoundUrl()
        }
        
    }
    
    
    var URLRequest: NSURLRequest {
        let URL = NSURL(string: path)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = Router.token {
            mutableURLRequest.setValue("\(token)", forHTTPHeaderField: "token")
        }
        
        mutableURLRequest.setValue("com.chinarongtai.fitnessbike", forHTTPHeaderField: "clientid")
        mutableURLRequest.setValue("1.0", forHTTPHeaderField: "appversion")
        
        println("mutableURLRequest: = \(mutableURLRequest)")
     
        
        switch self {
             case .SignUp(let params):
                return  Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            case .MsgResponse(let params):
                return  Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            default:
            
            return mutableURLRequest
        }
    }
}
