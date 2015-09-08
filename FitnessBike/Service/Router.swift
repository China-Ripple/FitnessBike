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

    case AllRanking(maxId:Int,count:Int)
    case SignIn(account:String,password:String)
    case SignUp(parameters:[String: AnyObject])
    
    var method: Alamofire.Method {
        switch self {
        case .AllRanking:
            return .GET
        case .SignIn(let account, let password):
            return .GET
        case .SignUp:
            return .POST
        default:
            return .GET
        }
        
    }
    
    
    var path: String {
        switch self {
        case .AllRanking(let maxId,let count):
            return ServiceApi.getAllRankingUrl(maxId,count:count)
        case .SignIn(let account, let password):
            return  ServiceApi.getSigninUrl(account, password:password)
        case .SignUp:
            return ServiceApi.getSignUpUrl()
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
        
        
     
        
        switch self {
             case .SignUp(let params):
                   println("params: \( Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0)")
                return  Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
             default:
            
            return mutableURLRequest
        }
    }
}
