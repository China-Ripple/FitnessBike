//
//  BlueToothBiz.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/16.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

enum BikeState{
    
    case Working
    case Syncing
    case Unknown
    
    
}


class BlueToothBiz:BleDataReslover{
   
    
    var bikeState:BikeState = .Unknown
    
    func work(){
        
        
    }
    
    func sync(){
        
    }
    
    func Unknown(){
        
    }
    
    func reslove(buffer: UnsafeMutablePointer<UInt8>) {
        
        println("接受到骑行机数据")
        
    }
    
    
    
}
