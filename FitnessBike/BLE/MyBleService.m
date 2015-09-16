//
//  MyBleService.m
//  Air Health Assistant
//
//  Created by xu da on 14-8-7.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "MyBleService.h"
#import "Const.h"

@implementation MyBleService

//@synthesize deviceList;
//@synthesize connectedDeviceName;
@synthesize state;
@synthesize mc10;
@synthesize bleDataResloverDele;
#define SOI 0xf0
#define EOI 0xf1
bool isThreadStarted;
NSMutableData *_readData;
int timeCount;
bool isSessionOpened;
uint8_t readData_index = 0;
uint8_t readData_temp_buffer[EAD_INPUT_BUFFER_SIZE];

+ (MyBleService *) getInstance:(id<BleDataReslover>) bleDataReslover
{
    static MyBleService	*this = nil;
    
	if (!this){
		this = [[MyBleService alloc] init];
        [this initData:bleDataReslover];
    }
    
    return this;
    
}

-(void)initData:(id<BleDataReslover>) bleDataReslover{
    NSLog(@"MyBleService initData");

    if (mc10 == nil) {
        mc10 = [[BleDevice alloc] init];
    }
    self.bleDataResloverDele = bleDataReslover;
    mc10.delegate = self;
    mc10.BLE_state = BLUETOOTH_STATE_DISCONNECT;
    mc10.bFlagConnected = FALSE;
    [mc10 findBLEPeripherals:1];
}
-(NSArray *)getDeviceList{
    NSLog(@"MyBleService getDeviceList:%@",mc10.peripherals);
    return mc10.peripherals;
}
-(NSString *)getConnectedDeviceName{
    NSLog(@"MyBleService getConnectedDeviceName:%@",mc10.activePeripheral.name);
    
    return mc10.activePeripheral.name;
}
-(void)changeState:(int)flg
{
    state = flg;
    //[[XBody getInstance]setBluetoothState_2:state];
    if(state == BLUETOOTH_STATE_CONNECTED)
    {
        isThreadStarted = true;
        [self createConnectedThread];
    }else{
        isThreadStarted = false;
    }
    NSLog(@"MyBleService changeState %d",state);
}
-(int)getState{
    NSLog(@"MyBleService getState:%d",state);
    
    return state;
}
- (void)sendData:(NSData *)data
{
    NSLog(@"MyBleService sendData:%@",data);
    [mc10 SendStrData:data p:mc10.activePeripheral];
}
-(void)dataRecieved:(NSData *)data
{
    NSLog(@"MyBleService dataRecieved:%@",data);
    /* need to delegate function */
    timeCount = 0;
    isSessionOpened = true;
    if (_readData == nil) {
        _readData = [[NSMutableData alloc] init];
    }
    //@synchronized(readLock){
    [_readData appendData:data];
    while ([_readData length] > INPUT_BUFFER_SIZE * 2) {
        NSLog(@"iGateDidReceivedData: too fast to catch!");
        [_readData replaceBytesInRange:NSMakeRange(0, INPUT_BUFFER_SIZE) withBytes:NULL length:0];
    }
    //}
    //NSLog(@"iGateDidReceivedData: %@",_readData);
    [self processData];

}
-(void)processData
{
    uint8_t dataValue[1];
    while (_readData != nil && [_readData length] > 0) {
        [_readData getBytes:dataValue length:1];
        [_readData replaceBytesInRange:NSMakeRange(0, 1) withBytes:NULL length:0];
        //get SOI
        if(dataValue[0] == SOI){
            readData_index = 0;
            readData_index++;
        } else if(dataValue[0] == EOI){
            //get EOI,save data
            if(readData_index > 0){
                [self processSaveData];
            }
            readData_index = 0;
        }else{
            //get Data
            if(readData_index < EAD_INPUT_BUFFER_SIZE){
                readData_temp_buffer[readData_index++] = dataValue[0];
            }
        }
    }
}

-(void)processSaveData
{
    NSLog(@"processSaveData");
    [bleDataResloverDele reslove:readData_temp_buffer];
   // XBody *xbody = [XBody getInstance];
    
//    //01显示，02控制
//    if(((readData_temp_buffer[1] >> 4) & 0x7) == 1){
//        //2程序版本号4
//        xbody.programVersion = readData_temp_buffer[1] & 0xf;
//        //3开关状态2  风扇状态3 负离子开关状态2
//        xbody.powerState = (readData_temp_buffer[2] >> 5) & 0x3;
//        xbody.airMotorState = (readData_temp_buffer[2] >> 2) & 0x7;
//        xbody.anionState = (readData_temp_buffer[2]) & 0x3;
//        //6总运行时间
//        xbody.totalRunTime = readData_temp_buffer[3] & 0x7f;
//        xbody.totalRunTime |= (readData_temp_buffer[4] & 0x7f) << 7;
//        //空气质量传感器输出电压
//        /*
//        xbody.aqGerneratorVoltage = readData_temp_buffer[5] & 0x7f;
//        xbody.aqGerneratorVoltage |= (readData_temp_buffer[6] & 0x7f) << 7;*/
//        
//        //空气质量传感器灰尘参数,L1:空气清洁 L2:轻度污染 L3:中度污染 L4:重度污染
//        xbody.airQualityDetector = (readData_temp_buffer[5] & 0x07);
//    }
//    NSLog(@"%d 开关状态:%d 风扇状态:%d 负离子开关状态:%d",((readData_temp_buffer[1] >> 4) & 0x7),xbody.powerState,xbody.airMotorState,xbody.anionState);
//
//    //UI signal
//    xbody.shouldUpdate_detail_device_for_data = YES;
}

-(void)close{
    NSLog(@"MyBleService close");
    
    [mc10 DisconnectPeripheral:mc10.activePeripheral];
}
//---------------------------------------------------------------------------------------------------------
-(void)createConnectedThread
{
    NSLog(@"createConnectedThread");
    //做线程是因为有的模块数据接收不过来,同时ios系统会被大数据流拖慢
    NSThread *connectThread = [[NSThread alloc]initWithTarget:self selector:@selector(connectedThreadMethod) object:nil];
    [connectThread start];
}

//数据包定时发送
-(void)connectedThreadMethod
{
    while (isThreadStarted) {
        @try {
//            //5秒
//            sleep(1);
//            XBody *xbody = [XBody getInstance];
//            NSMutableData *data = [NSMutableData data];
//            uint8_t tmp[4];
//            tmp[0] = SOI;
//            //数据包标识3,警告信息1,PM2.5数据低3位
//            tmp[1]  = 0x01;//01显示，02控制
//            tmp[1] |= (xbody.warnSignal << 3) & 0x1;
//            tmp[1] |= (xbody.pm25Data >> 7) & 0x3;
//            tmp[2] = xbody.pm25Data & 0x7f;
//            tmp[3] = EOI;
//            [data appendBytes:(void *)(&tmp) length:4];
//            [mc10 SendStrData:data p:mc10.activePeripheral];
            //NSLog(@"定时发送显示包:%@",data);
        }
        @catch (NSException *exception) {
        }
    }
}

@end
