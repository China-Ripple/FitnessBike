//
//  Utility.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/8.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class Utility: NSObject {

    class func showMsg(msg:String) {
        var alert = UIAlertView(title: "提醒", message: msg, delegate: nil, cancelButtonTitle: "确定")
        alert.show()
    }

    
    class func enterMainScreen(selfCtrler:UIViewController){
        
        var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var viewCtrl:UITabBarController = storyboard.instantiateViewControllerWithIdentifier("mainCtrl") as! UITabBarController
        var mainVC=UINavigationController(rootViewController: UITableViewController())
        selfCtrler.presentViewController(viewCtrl, animated: true, completion: nil)
    }
}
