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
let RUNNING_DURATION = "runningDuration"


protocol BTSyncCallBack {
    func getCurrData(data:Double,duration:Int64);
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
    //运行时间
    var duration:Int64! = 0
    
    var count:Int! = 0
    
    var prefs = NSUserDefaultsPrefs(prefix: BLE_DATA_PREFS_NAME)
    
     var weight:Int =  User.sharedInstance.weight
    
    internal var things: NSMutableDictionary = NSMutableDictionary()
    
    //const unsigned int aw_BI_Watts[16][24]
    //RMP:25 30 35  40  45  50  55  60  65  70  75  80  85  90  95  100 105 110 115 120 125 130 135 140
    let  aw_BI_Watts =                                                                                 //阻力
    [
        [8,11,13, 14, 16, 17, 19, 21, 22, 23, 25, 27, 28, 29, 30, 31, 32, 33, 34, 35, 37, 39, 51, 52],//L1
        [19,23,24, 25, 30, 35, 36, 37, 42, 47, 48, 49, 50, 52, 55, 59, 63, 68, 72, 77, 80, 84, 90, 97], //L2
        [33,30,33, 36, 42, 49, 51, 52, 58, 65, 66, 67, 71, 75, 78, 81, 86, 92, 98, 105,108,110,117,125], //L3
        [40,39,43, 47, 54, 62, 64, 67, 76, 84, 86, 89, 93, 98, 103,108,113,119,125,131,134,138,145,153], //L4
        [48,46,51, 56, 64, 73, 78, 82, 91, 100,103,107,113,119,125,131,136,142,150,158,163,168,176,185], //L5
        [57,55,62, 68, 78, 88, 93, 98, 109,120,125,130,137,145,152,159,166,174,183,192,197,203,213,224], //L6
        [58,64,71, 78, 89, 101,107,113,126,140,136,151,160,169,178,187,194,202,213,224,230,237,247,258], //L7
        
        
        //        [58,71,79, 87, 99, 112,120,128,141,154,161,168,179,190,199,208,217,226,237,248,257,266,228,290], //L8
        //        [58,78,87, 98, 111,124,133,143,157,172,180,189,200,212,223,235,244,253,267,281,290,300,314,328], //L9
        //        [58,78,98, 109,123,138,148,159,174,190,199,209,221,234,247,260,272,284,298,313,325,337,352,368], //L10
        //        [58,78,102,119,136,151,162,174,190,207,219,230,244,258,271,285,297,310,326,342,354,367,386,405], //L11
        //        [58,78,102,124,148,163,176,189,207,225,237,250,265,281,297,313,325,338,356,374,388,403,424,445], //L12
        //        [58,78,102,124,159,177,192,204,223,243,256,269,286,304,320,336,351,366,384,402,418,434,457,480], //L13
        //        [58,78,102,124,159,183,209,219,240,261,275,290,307,325,342,360,377,394,414,434,450,467,490,513], //L14
        //        [58,78,102,124,159,183,223,234,255,277,292,308,327,347,364,382,399,416,438,460,478,497,522,547], //L15
        //        [58,78,102,124,159,183,224,245,269,293,310,327,347,367,387,407,423,440,464,489,506,524,551,578]//L16
    ];
    
    let RPM = [25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140]
    
    func getCalorie(rpm:Int, gear:Int)->Float{
        //卡路里/每分钟=(((瓦特×6)×2)+(3.5×体重(千克.)))×0.005
        //先计算大概的瓦特
        
        var r = gear - 1
        
        if(rpm < RPM[0] || rpm > RPM[RPM.count-1] || rpm < 24 || r < 0 || r >= 7){
            return -1
        }
        
        
        
        
        
        var greaterIndex:Int = -1
        
        for (index,item) in enumerate(RPM) {
            if(item > rpm){
                greaterIndex = index
                break
            }
        }
        
       
        
        var watt:Int = aw_BI_Watts[r][greaterIndex]
        
         println("rpm: \(rpm) ,gear:\(r), watt:\(watt), greaterIndex:\(greaterIndex)")
       
        var calorie =   (Float((watt*6)*2) + (3.5 * Float(weight))) * 0.005
        
        
        println("calorie : \(calorie)")
        
        return calorie
        
        
       
        
        
    }
    
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
    
    func update(data:BlueToothBaseModel){

        
        
        invokeCallBacks(Double(getCalorie(data.velocity,gear: data.gear)),duration: duration)
        
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
        duration = duration + Int64(data.timeInterval)
        
        if(count > data.recordCount ){
            block = true
            save()
            block = false
            return
        }
        
        invokeCallBacks(Double(totalDistance),duration: duration)
       
        
    }
    
    func invokeCallBacks( data:Double, duration:Int64){
        for cb  in callbacks {
            cb.getCurrData(data,duration: duration)
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
    
    
    func getDuration()->Int64
    {
        return duration
    }
    
    func getCalorie(distance:Int64,duration:Timestamp,gear:Int){
        
        
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
        println("速度：\(data.velocity)")
        data.timeInterval = Int(((transferBuffer[4] & 0x7f) << 7)|(transferBuffer[5] & 0x7f))
        //println("时间：\(data.timeInterval)")
        data.checkSum =  Int(transferBuffer[6] & 0x7f)
        //println("checkSum：\(data.checkSum)")
        
        SyncProcessor.shared.update(data)
        
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
