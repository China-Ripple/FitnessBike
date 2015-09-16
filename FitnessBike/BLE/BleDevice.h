//
//  BleDevice.h
//  Ebeacon
//
//  Created by 金鑫 on 14-5-2.
//  Copyright (c) 2014年 Ehong Link. All rights reserved.
//

#ifndef Ebeacon_BleDevice_h
#define Ebeacon_BleDevice_h

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>
#import "MC10_GATT_DEFINE.H"

/*
@protocol BleDeviceDelegate
@optional
-(void)play;
- (void)DisplayData:(NSData *)d;
@required
@end*/

@protocol MyBleServiceDelegate
@optional
-(void)changeState:(int)flg;
-(void)dataRecieved:(NSData *)data;
@end

@protocol BleDataReslover

@optional
-(void) reslove:(uint8_t[])buffer;
@end

@interface BleDevice : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate> {
}

@property int BLE_state;

@property (nonatomic) bool bFlagConnected;

//@property (weak, nonatomic)  UITextField *Send_ASCII;
//@property (weak, nonatomic)  UITextField *Send_HEX;

@property (nonatomic,assign) id <MyBleServiceDelegate> delegate;
@property (strong, nonatomic)  NSMutableArray *peripherals;
@property (strong, nonatomic) CBCentralManager *CM;
@property (strong, nonatomic) CBPeripheral *activePeripheral;

-(void) writeValue:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID  p:(CBPeripheral *)p data:(NSData *)data;
-(void) readValue: (CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID  p:(CBPeripheral *)p;
-(void) notification:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID  p:(CBPeripheral *)p on:(BOOL)on;


-(int) findBLEPeripherals:(int) timeout;

-(const char *) CBUUIDToString:(CBUUID *) UUID;
-(void) getAllCharacteristicsBeacon:(CBPeripheral *)p;
- (void) DisconnectPeripheral:(CBPeripheral *)peripheral;


///////app api//////////////
-(void) SendStr:(NSString *)str p:(CBPeripheral *)p;
-(void) SendStrData:(NSData*)buzVal p:(CBPeripheral *)p;
@end





#endif
