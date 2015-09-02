//
//  BleDevice.m
//  Ebeacon
//
//  Created by 金鑫 on 14-5-2.
//  Copyright (c) 2014年 Ehong Link. All rights reserved.
//

#include <stdio.h>
#include "BleDevice.h"
#include "Const.h"

@implementation BleDevice


@synthesize activePeripheral;
@synthesize CM;
@synthesize bFlagConnected;
@synthesize peripherals;
@synthesize delegate;

/*
 *  @method compareCBUUID
 *
 *  @param UUID1 UUID 1 to compare
 *  @param UUID2 UUID 2 to compare
 *
 *  @returns 1 (equal) 0 (not equal)
 *
 *  @discussion compareCBUUID compares two CBUUID's to each other and returns 1 if they are equal and 0 if they are not
 *
 */

-(int) compareCBUUID:(CBUUID *) UUID1 UUID2:(CBUUID *)UUID2 {
    char b1[16];
    char b2[16];
    [UUID1.data getBytes:b1];
    [UUID2.data getBytes:b2];
    if (memcmp(b1, b2, UUID1.data.length) == 0)return 1;
    else return 0;
}



////get the uuid of the general define
- (CBUUID *)serviceUUID{
    /*
     BOOL enabled_customUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"enalbe uuid128"];
     NSString *customUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"customUUID"];
     if(enabled_customUUID)
     printf("serviceUUID-------------\r\n");
     else
     printf(">>>>>>>>>>>>>>>\r\n");
     if (enabled_customUUID && [customUUID length] > 0) {
     return [CBUUID UUIDWithString:customUUID];
     printf("use the customer uuid\r\n");
     }else{
     return MC10_DEFAULT_UUID;
     }*/
    return MC10_DEFAULT_UUID;
}



-(UInt16) swap:(UInt16)s {
    UInt16 temp = s << 8;
    temp |= (s >> 8);
    return temp;
}


/*
 *  @method findServiceFromUUID:
 *
 *  @param UUID CBUUID to find in service list
 *  @param p Peripheral to find service on
 *
 *  @return pointer to CBService if found, nil if not
 *
 *  @discussion findServiceFromUUID searches through the services list of a peripheral to find a
 *  service with a specific UUID
 *
 */
-(CBService *) findServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)p {
    for(int i = 0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        if ([self compareCBUUID:s.UUID UUID2:UUID]) return s;
    }
    return nil; //Service not found on this peripheral
}


-(CBCharacteristic *) findCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service {
    for(int i=0; i < service.characteristics.count; i++) {
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        if ([self compareCBUUID:c.UUID UUID2:UUID]) return c;
    }
    return nil; //Characteristic not found on this service
}
/*!
 *  @method writeValue:
 *
 *  @param serviceUUID Service UUID to write to (e.g. 0x2400)
 *  @param characteristicUUID Characteristic UUID to write to (e.g. 0x2401)
 *  @param data Data to write to peripheral
 *  @param p CBPeripheral to write to
 *
 *  @discussion Main routine for writeValue request, writes without feedback. It converts integer into
 *  CBUUID's used by CoreBluetooth. It then searches through the peripherals services to find a
 *  suitable service, it then checks that there is a suitable characteristic on this service.
 *  If this is found, value is written. If not nothing is done.
 *
 */

-(void) writeValue:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID p:(CBPeripheral *)p data:(NSData *)data{
    if ([p state] == CBPeripheralStateConnected)
    {
        CBService *service = [self findServiceFromUUID:serviceUUID p:p];
        CBCharacteristic *characteristic = [self findCharacteristicFromUUID:characteristicUUID service:service];
        //NSLog(@"characteristicUUID:%@,%@",characteristicUUID,characteristic);
        
        [p writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    }
    else{
        NSLog(@"ble device not connected!");
    }
}


/*!
 *  @method readValue:
 *
 *  @param serviceUUID Service UUID to read from (e.g. 0x2400)
 *  @param characteristicUUID Characteristic UUID to read from (e.g. 0x2401)
 *  @param p CBPeripheral to read from
 *
 *  @discussion Main routine for read value request. It converts integers into
 *  CBUUID's used by CoreBluetooth. It then searches through the peripherals services to find a
 *  suitable service, it then checks that there is a suitable characteristic on this service.
 *  If this is found, the read value is started. When value is read the didUpdateValueForCharacteristic
 *  routine is called.
 *
 *  @see didUpdateValueForCharacteristic
 */

-(void) readValue: (CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID p:(CBPeripheral *)p {
    
    if ([p state] == CBPeripheralStateConnected)
    {
        CBService *service = [self findServiceFromUUID:serviceUUID p:p];
        CBCharacteristic *characteristic = [self findCharacteristicFromUUID:characteristicUUID service:service];
        
        [p readValueForCharacteristic:characteristic];
    }
    else{
        NSLog(@"ble device not connected!");
    }
}


/*!
 *  @method notification:
 *
 *  @param serviceUUID Service UUID to read from (e.g. 0x2400)
 *  @param characteristicUUID Characteristic UUID to read from (e.g. 0x2401)
 *  @param p CBPeripheral to read from
 *
 *  @discussion Main routine for enabling and disabling notification services. It converts integers
 *  into CBUUID's used by CoreBluetooth. It then searches through the peripherals services to find a
 *  suitable service, it then checks that there is a suitable characteristic on this service.
 *  If this is found, the notfication is set.
 *
 */
-(void) notification:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID p:(CBPeripheral *)p on:(BOOL)on {
    CBUUID *su = serviceUUID;
    CBUUID *cu = characteristicUUID;
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        return;
    }
    [p setNotifyValue:on forCharacteristic:characteristic];
}

- (instancetype)init{
    self = [super init];
    self.CM = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    return self;
}

- (int) findBLEPeripherals:(int) timeout {
    NSLog(@"findBLEPeripherals %@",[self serviceUUID]);
    //self.TextUUID.text =@"11223344556677889900AABBCCDDEEFF";
    //[[self delegate] play];
    if (self.CM.state  != CBCentralManagerStatePoweredOn) {
        printf("CoreBluetooth not correctly initialized !\r\n");
        return -1;
    }
    self.BLE_state = BLUETOOTH_STATE_CONNECTING;
    [delegate changeState:self.BLE_state];
    
    [self.CM scanForPeripheralsWithServices:@[[self serviceUUID]] options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    // Start scanning
    printf("CoreBluetooth start find device !\r\n");
    return 0; // Started scanning OK !
}

- (void) connectPeripheral:(CBPeripheral *)peripheral {
    
    activePeripheral = peripheral;
    activePeripheral.delegate = self;
    [CM connectPeripheral:peripheral options:nil];
}

- (void) DisconnectPeripheral:(CBPeripheral *)peripheral {
    
    [CM cancelPeripheralConnection:peripheral];
}



-(void) enableUpdate:(CBPeripheral *)p {
    
    //[self notification:0xfff0 characteristicUUID:0x2a1c p:p on:NO];
    [self notification:MC10_DEFAULT_UUID characteristicUUID:MC10_DATA_UUID p:p on:YES];
}
//----------------------------------------------------------------------------------------------------
//
//
//
//
//CBCentralManagerDelegate protocol methods beneeth here
// Documented in CoreBluetooth documentation
//
//
//
//
//----------------------------------------------------------------------------------------------------




- (void) centralManagerDidUpdateState:(CBCentralManager *)central
{
    static CBCentralManagerState previousState = -1;
    NSLog(@"centralManagerDidUpdateState:%d",[CM state]);
    int state = [CM state];
	switch (state) {
		case CBCentralManagerStatePoweredOff:
		{
            [peripherals removeAllObjects];
            
			/* Tell user to power ON BT for functionality, but not on first run - the Framework will alert in that instance. */
            //[discoveryDelegate discoveryStatePoweredOff];
            
			break;
		}
            
		case CBCentralManagerStateUnauthorized:
		{
			/* Tell user the app is not allowed. */
			break;
		}
            
		case CBCentralManagerStateUnknown:
		{
			/* Bad news, let's wait for another event. */
			break;
		}
            
		case CBCentralManagerStatePoweredOn:
		{
            //查找
			[self findBLEPeripherals:1];
			break;
		}
            
		case CBCentralManagerStateResetting:
		{
            [peripherals removeAllObjects];
			break;
		}
	}
    
    previousState = [CM state];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"customName = %@", peripheral.name);
    
    //添加到列表
 	if (![peripherals containsObject:peripheral]) {
		[peripherals addObject:peripheral];
	}
    
    [self connectPeripheral:peripheral];
    
    self.BLE_state = BLUETOOTH_STATE_CONNECTING;
    [delegate changeState:self.BLE_state];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"connected = %@", peripheral.name);
    
    //    [self.TextState setText:@"connected"];
    self.activePeripheral = peripheral;
    [self.activePeripheral discoverServices: @[MC10_DEFAULT_UUID]];
    [central stopScan];
    self.bFlagConnected = TRUE;
    self.BLE_state = BLUETOOTH_STATE_CONNECTED;
    [delegate changeState:self.BLE_state];
    
    //[[self delegate] play];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
    printf("disconnect the device!\r\n");
    self.BLE_state = BLUETOOTH_STATE_DISCONNECT;
    [delegate changeState:self.BLE_state];
    
    self.bFlagConnected = FALSE;
}

-(const char *) CBUUIDToString:(CBUUID *) UUID {
    return [[UUID.data description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy];
}


-(void) getAllCharacteristicsBeacon:(CBPeripheral *)p{
    
    for (int i=0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        
        printf("Fetching characteristics for service with UUID : %s\r\n",[self CBUUIDToString:s.UUID]);
        [p discoverCharacteristics:nil forService:s];
        
    }
}
//----------------------------------------------------------------------------------------------------
//
//
//
//
//
//CBPeripheralDelegate protocol methods beneeth here
//
//
//
//
//
//----------------------------------------------------------------------------------------------------


/*
 *  @method didDiscoverCharacteristicsForService
 *
 *  @param peripheral Pheripheral that got updated
 *  @param service Service that characteristics where found on
 *  @error error Error message if something went wrong
 *
 *  @discussion didDiscoverCharacteristicsForService is called when CoreBluetooth has discovered
 *  characteristics on a service, on a peripheral after the discoverCharacteristics routine has been called on the service
 *
 */

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    for(int i=0; i < service.characteristics.count; i++) {
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        printf("Found characteristic %s\r\n",[ self CBUUIDToString:c.UUID]);
        CBUUID *cu = [CBUUID UUIDWithString:@"0x4a5b"];
        
        if([self compareCBUUID:cu UUID2:c.UUID]==1){
            NSLog(@"read the uuid characteristic!");
            [self enableUpdate: peripheral];
            //[self readValue:service.UUID characteristicUUID:cu p:peripheral];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(NSError *)error {
}

/*
 *  @method didDiscoverServices
 *
 *  @param peripheral Pheripheral that got updated
 *  @error error Error message if something went wrong
 *
 *  @discussion didDiscoverServices is called when CoreBluetooth has discovered services on a
 *  peripheral after the discoverServices routine has been called on the peripheral
 *
 */

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if(!error){
        NSLog(@"Services = %@", peripheral.services);
        //[self getAllCharacteristicsBeacon:peripheral];
        //self.TextUUID.text =@"11223344556677889900aabbccddeeff";
        for (CBService *service in peripheral.services) {
            [peripheral discoverCharacteristics:nil/*EBEACON_CHAR1_UUID*/ forService:service];
        }
        
    }
}

/*
 *  @method didUpdateNotificationStateForCharacteristic
 *
 *  @param peripheral Pheripheral that got updated
 *  @param characteristic Characteristic that got updated
 *  @error error Error message if something went wrong
 *
 *  @discussion didUpdateNotificationStateForCharacteristic is called when CoreBluetooth has updated a
 *  notification state for a characteristic
 *
 */

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (!error) {
        
    }
    else {
        
        printf("Error code was %s\r\n",[[error description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy]);
    }
    
}

/*
 *  @method didUpdateValueForCharacteristic
 *
 *  @param peripheral Pheripheral that got updated
 *  @param characteristic Characteristic that got updated
 *  @error error Error message if something went wrong
 *
 *  @discussion didUpdateValueForCharacteristic is called when CoreBluetooth has updated a
 *  characteristic for a peripheral. All reads and notifications come here to be processed.
 *
 */
//TODO 收到数据处理
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    //UInt16 characteristicUUID = [self CBUUIDToInt:characteristic.UUID];
    
    if (!error) {
        if (error) {
            NSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
            return;
        }
        
        //NSString *stringFromData = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
        
        char rData[999];
        int len = characteristic.value.length;
        
        [characteristic.value getBytes:rData length:len];
        NSData *d = [[NSData alloc] initWithBytes:rData length:len];
        [delegate dataRecieved:d];

    }
    else {
        printf("updateValueForCharacteristic failed !");
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error {
    NSLog(@"read value ok!");
    
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    //NSLog(@"write value ok");
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error {
    
    NSLog(@"value write callback!");
    
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error {
    
    
}

//////////////////////app api///////////////////
-(void) SendStr:(NSString *)str p:(CBPeripheral *)p{
    //NSData *d = [[NSData alloc] initwiths:buzVal length:3];
    NSData *d = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self writeValue:MC10_DEFAULT_UUID characteristicUUID:MC10_DATA_UUID
                   p:p data:d];
}

-(void) SendStrData:(NSData*)buzVal p:(CBPeripheral *)p{
    @try {
        [self writeValue:MC10_DEFAULT_UUID characteristicUUID:MC10_DATA_UUID
                       p:p data:buzVal];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}




@end