//
//  Prefs.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/15.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import Foundation
public typealias Timestamp = UInt64
public struct PrefsKeys {
    public static let KeyLastRemoteTabSyncTime = "lastRemoteTabSyncTime"
    public static let KeyLastSyncFinishTime = "lastSyncFinishTime"
}

public protocol Prefs {
    func branch(branch: String) -> Prefs
    func setTimestamp(value: Timestamp, forKey defaultName: String)
    func setLong(value: UInt64, forKey defaultName: String)
    func setLong(value: Int64, forKey defaultName: String)
    func setInt(value: Int32, forKey defaultName: String)
    func setString(value: String, forKey defaultName: String)
    func setBool(value: Bool, forKey defaultName: String)
    func setObject(value: AnyObject?, forKey defaultName: String)
    func stringForKey(defaultName: String) -> String?
    func boolForKey(defaultName: String) -> Bool?
    func intForKey(defaultName: String) -> Int32?
    func timestampForKey(defaultName: String) -> Timestamp?
    func longForKey(defaultName: String) -> Int64?
    func unsignedLongForKey(defaultName: String) -> UInt64?
    func stringArrayForKey(defaultName: String) -> [String]?
    func arrayForKey(defaultName: String) -> [AnyObject]?
    func dictionaryForKey(defaultName: String) -> [String : AnyObject]?
    func removeObjectForKey(defaultName: String)
    func clearAll()
}


