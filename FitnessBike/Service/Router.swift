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

    
    var method: Alamofire.Method {
        switch self {
        case .AllRanking:
            return .GET
        default:
            return .GET
        }
        
    }
    
    
    var path: String {
        switch self {
        case .AllRanking(let maxId,let count):
            return ServiceApi.getAllRankingUrl(maxId,count:count)
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
//            case .AllRanking(let maxId,let count):
//                let params = ["maxId":maxId,"maxId":maxId]
//                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            default:
            return mutableURLRequest
        }
    }
}
