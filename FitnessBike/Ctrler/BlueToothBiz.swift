//
//  BlueToothBiz.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/16.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

enum WorkState{
    
    case Running
    case Syncing
    case Unknown
    
    
}
let GEAR_MAX_NUM = 7
class BlueToothBaseModel{
    //主版本号
    var mainVersion:Int!
    //副版本号
    var slaveVersion:Int!
    //档数
    var gear:Int!
    //状态
    var bikeState:WorkState = .Unknown
    //速度
    var velocity:Int!
    //时间
    var timeInterval:Int!
    //CheckSum
    var checkSum:Int!
  
}

class BlueToothSyncModel:BlueToothBaseModel{
    
    //记录
    var recordCount:Int!
    //年
    var year:Int!
    //月
    var month:Int!
    //日
    var date:Int!
    //路程
    var distance:Int!
}

class GearModel{
    var gear:Int!
    var distance:Int!
}

class SyncProcessor{
  internal var things: NSMutableDictionary = NSMutableDictionary()
  class var shared: SyncProcessor {
        return Inner.instance
  }
        
  struct Inner {
            static let instance: SyncProcessor = SyncProcessor()
  }
    
    func sync(data:BlueToothSyncModel){
        
        if let d = things.objectForKey(data.gear){
            var curr = d as! GearModel
            curr.distance = data.distance +  curr.distance
        }
        else{
            var gear = GearModel()
            gear.gear = data.gear
            gear.distance = data.distance
            things.setObject(gear, forKey: gear.gear)
        }

    }
    
}



class BlueToothBiz:BleDataReslover{
    
 
   
    var  transferBuffer:UnsafeMutablePointer<UInt8>!
    
    
    func work(){
        
        var data  = BlueToothBaseModel()
        data.bikeState = .Running
        data.mainVersion = ((transferBuffer[1] >> 4) & 0x7) as! Int
        data.slaveVersion = (transferBuffer[2] & 0x7f) as! Int
        data.gear = (transferBuffer[3] & 0x0f) as! Int
        data.velocity = (transferBuffer[4] & 0x7f) as! Int
        data.timeInterval = (((transferBuffer[5] & 0x7f) << 7)|(transferBuffer[6] & 0x7f)) as! Int
        data.checkSum =  (transferBuffer[7] & 0x7f) as! Int
        
        

    }
    
    func sync(){
        
        var data = BlueToothSyncModel()
        data.bikeState = .Syncing
        data.mainVersion = ((transferBuffer[1] >> 4) & 0x7) as! Int
        data.slaveVersion = (transferBuffer[2] & 0x7f) as! Int
        data.recordCount = (transferBuffer[4] & 0x7f) as! Int
        data.year = (transferBuffer[5] & 0x7f) as! Int
        data.month  = (transferBuffer[6] & 0x7f) as! Int
        data.date  = (transferBuffer[7] & 0x7f) as! Int
        data.gear = (transferBuffer[8] & 0x0f) as! Int
        data.distance = (transferBuffer[9] & 0x0f) as! Int
        data.timeInterval = (((transferBuffer[10] & 0x7f) << 7)|(transferBuffer[11] & 0x7f)) as! Int
        data.checkSum =  (transferBuffer[12] & 0x7f) as! Int
        
        SyncProcessor.shared.sync(data)
    }
    
    
    
    func Unknown(){
        
    }
    
    func reslove(readData_temp_buffer: UnsafeMutablePointer<UInt8>) {
        
        println("接受到骑行机数据")
        
        self.transferBuffer = readData_temp_buffer

        var state = ((readData_temp_buffer[3]>>4) & 0x7) as! Int
        switch(state){
        case 1:

            work()
        case 2:
            
            sync()
        default:

            Unknown()
        }
        
        
        
        
    }
    
    
    
}
