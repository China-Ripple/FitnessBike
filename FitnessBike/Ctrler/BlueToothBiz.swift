//
//  BlueToothBiz.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/16.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import Alamofire
let BLE_DATA_PREFS_NAME = "bleDataPrefs"
let GEAR_MAX_NUM = 7
let TOTAL_DISTANCE = "totalDistance"


protocol BTSyncCallBack {
    func getCurrData(data:Int64);
}
enum WorkState :Int{
    
    case Unknown
    case Running
    case Syncing
    
    
    
}

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
    var distance:Int64!
}

class GearModel{
    var gear:Int!
    var distance:Int64!
}

class SyncProcessor{
    var callbacks:[BTSyncCallBack] = [BTSyncCallBack]()
    var totalDistance:Int64 = 0
    //排斥锁，正在写数据库的时候不允许访问数据库
    var block:Bool! = false
    //数据库是否有增加新内容的标示
    var newData:Bool! = true
    //临时保存数据库当前峰值
    var temDataOnDB:Int64! = 0
    var count:Int! = 0
    var prefs = NSUserDefaultsPrefs(prefix: BLE_DATA_PREFS_NAME)
    internal var things: NSMutableDictionary = NSMutableDictionary()
    class var shared: SyncProcessor {
        return Inner.instance
    }
    
    struct Inner {
        
        static let instance: SyncProcessor = SyncProcessor()
    }
    
    func registerCallBace(cb:BTSyncCallBack){
        
        self.callbacks.append(cb)
    }
    
    private func name(key: String) -> String {
        var nameWithDot =  BLE_DATA_PREFS_NAME+"."
        return nameWithDot+key
    }
    
    
    func push(data:BlueToothSyncModel){
        
        println("count :\(count) , recordCount:\(data.recordCount)")
        
        if let d = things.objectForKey(name("\(data.gear)")){
            var curr = d as! GearModel
            curr.distance = data.distance +  curr.distance
            totalDistance = totalDistance +  curr.distance
            things.setObject(curr, forKey: name("\(curr.gear)"))
            println("old data")
        }
        else{
            var gear = GearModel()
            gear.gear = data.gear
            gear.distance = data.distance
            things.setObject(gear, forKey: name("\(gear.gear)"))
            
            totalDistance = totalDistance +  gear.distance
            println("new data")
            //            if(count >= data.recordCount){
            //
            //            }
        }
        count = count + 1
        
        if(count > data.recordCount ){
            block = true
            save()
            block = false
            return
        }
        
        
        for cb  in callbacks {
            cb.getCurrData(totalDistance)
        }
        
    }
    
    func save(){
        println("starts to save data...")
        
        
        
        for item in things.objectEnumerator(){
            //如果发现数据存储中还存在以前的数据，需要将数据进行累加
            var gear = item as! GearModel
            
            if let prefsDis = prefs.longForKey("\(gear.gear)")
            {
                
                
                var distance = (prefsDis as! Int64) + gear.distance
                prefs.setLong(distance, forKey:"\(gear.gear)")
                println("saved gear: \(gear.gear) , distance: \( distance)")
                
            }
            else{
                println("new gear: \(gear.gear) , distance: \( gear.distance)")
                prefs.setLong(gear.distance, forKey:"\(gear.gear)")
                
                
            }
            
        }
        things.removeAllObjects()
        
        if let distance = prefs.longForKey(TOTAL_DISTANCE){
            
            prefs.setLong(totalDistance + distance, forKey:TOTAL_DISTANCE)
            println("save with old data...\(totalDistance + distance)")
        }
        else{
            println("ends to save data...\(totalDistance)")
            prefs.setLong(totalDistance , forKey:TOTAL_DISTANCE)
        }
        
        
        
        onSavedCompleted()
    }
    
    func saveWithJson(){
        
    }
    
    func onSavedCompleted(){
        newData = true
        totalDistance = 0
    }
    //将文件中的内容上传到服务器
    func sync(){
        
        let parameters = ["account":"bbbb","password":"cccc","checknum":"11111"]
        Alamofire.request(Router.Sync(parameter:json as! [String : AnyObject] )).responseJSON{
            (_,_,json,error) in
            
                println("data: \(json)")
                
                var result = JSON(json!)
                Utility.showNetMsg(result)
        }

    }
    
    var json: AnyObject {
        
        get {
            var json: [String: AnyObject] = [:]
            
            json["calorie"] = fetch() as! AnyObject
            json["distance"] = fetch() as! AnyObject

            return json
        }
    }
    
    func fetch()->Int64{
        if(block == true){
            return 0
        }
        
        if(newData == true)
        {
            newData = false
            if let distance = prefs.longForKey(TOTAL_DISTANCE){
                println("fetch distance: \(distance)")
                temDataOnDB = distance
                return distance + totalDistance
            }
        }

        return totalDistance+temDataOnDB
    }
    
    
}



class BlueToothBiz:BleDataReslover{
    
    
    
    
    var  transferBuffer:UnsafeMutablePointer<UInt8>!
    
    
    func work(){
        
        var data  = BlueToothBaseModel()
        data.bikeState = .Running
        //println("工作模式：\(data.bikeState.hashValue)")
        data.mainVersion = Int(((transferBuffer[1] >> 4) & 0x7))
        //println("主版本号：\(data.mainVersion)")
        data.slaveVersion = Int((transferBuffer[1] & 0x07))
        //println("副版本号：\(data.slaveVersion)")
        data.gear = Int(transferBuffer[2] & 0x0f)
        //println("阻力：\(data.gear)")
        data.velocity = Int(transferBuffer[3] & 0x7f)
        //println("速度：\(data.velocity)")
        data.timeInterval = Int(((transferBuffer[4] & 0x7f) << 7)|(transferBuffer[5] & 0x7f))
        //println("时间：\(data.timeInterval)")
        data.checkSum =  Int(transferBuffer[6] & 0x7f)
        //println("checkSum：\(data.checkSum)")
        
        
        
    }
    
    func sync(){
        
        var data = BlueToothSyncModel()
        data.bikeState = .Syncing
        //println("工作模式：\(data.bikeState.hashValue)")
        data.mainVersion = Int((transferBuffer[1] >> 4) & 0x7)
        //println("主版本号：\(data.mainVersion)")
        data.slaveVersion = Int(transferBuffer[1] & 0x07)
        //println("副版本号：\(data.slaveVersion)")
        data.recordCount = Int(transferBuffer[3] & 0x7f)
        //println("记录总数：\(data.recordCount)")
        data.year = Int(transferBuffer[4] & 0x7f)
        //println("年：\(data.year)")
        data.month  = Int(transferBuffer[5] & 0x7f)
        //println("月：\(data.month)")
        data.date  = Int(transferBuffer[6] & 0x7f)
        //println("日：\(data.date)")
        data.gear = Int(transferBuffer[7] & 0x0f)
        //println("阻力：\(data.gear)")
        data.distance = Int64(transferBuffer[8] & 0x7f)
        //println("里程：\(data.distance)")
        data.timeInterval = Int(((transferBuffer[9] & 0x7f) << 7)|(transferBuffer[10] & 0x7f))
        //println("时间：\(data.timeInterval)")
        data.checkSum =  Int(transferBuffer[11] & 0x7f)
        //println("CheckSum：\(data.checkSum)")
        
        SyncProcessor.shared.push(data)
    }
    
    
    
    func Unknown(){
        
    }
    
    func reslove(readData_temp_buffer: UnsafeMutablePointer<UInt8>) {
        
        //println("接受到骑行机数据")
        
        
        self.transferBuffer = readData_temp_buffer
        
        
        
        var state = ((readData_temp_buffer[2]>>4) & 0x07) as! UInt8
        
        // println("state: \(state)")
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
