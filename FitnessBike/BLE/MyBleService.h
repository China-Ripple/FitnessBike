//
//  MyBleService.h
//  Air Health Assistant
//
//  Created by xu da on 14-8-7.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BleDevice.h"

//#define STATE_DATA_ERROR        3
//#define STATE_DATA_RECIEVED     2
//#define STATE_START             1
//#define STATE_STOP              0
//

//#define EAD_INPUT_BUFFER_SIZE 20

#define BLE_SERVICE_STATE_DISCONNECTED      0
#define BLE_SERVICE_STATE_CONNECTING        1
#define BLE_SERVICE_STATE_CONNECTED         2
#define INPUT_BUFFER_SIZE                   99

@interface MyBleService : NSObject<MyBleServiceDelegate>
{
    BleDevice* mc10;
}
//@property NSArray *deviceList;
//@property NSString *connectedDeviceName;
@property int state;
@property BleDevice* mc10;
@property id<BleDataReslover> bleDataResloverDele;

+ (MyBleService *) getInstance:(id<BleDataReslover>) bleDataReslover;

-(void)initData:(id<BleDataReslover>) bleDataReslover;
-(NSArray *)getDeviceList;
-(NSString *)getConnectedDeviceName;
-(int)getState;
- (void)sendData:(NSData *)data;
-(void)close;

@end
