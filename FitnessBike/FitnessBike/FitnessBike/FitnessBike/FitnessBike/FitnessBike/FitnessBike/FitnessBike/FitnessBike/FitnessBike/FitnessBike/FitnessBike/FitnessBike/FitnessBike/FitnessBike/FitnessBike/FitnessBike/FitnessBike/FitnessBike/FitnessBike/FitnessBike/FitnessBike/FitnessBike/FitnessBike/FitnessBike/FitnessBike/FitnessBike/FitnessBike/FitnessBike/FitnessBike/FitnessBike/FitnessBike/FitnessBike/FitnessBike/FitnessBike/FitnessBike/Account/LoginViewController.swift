//
//  LoginViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/31.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
    }
    
    func layout(){
        
        var headerBar = UIView(frame: CGMakeRect(0, 0,375, 80))
        
        var backItem = UIButton(frame: CGMakeRect(20, 25, 35, 30))
        backItem.setImage(UIImage(named: "back"), forState:UIControlState.Normal)
        backItem.addTarget(self, action: "onBackSeleted:", forControlEvents: UIControlEvents.TouchUpInside)
        headerBar.addSubview(backItem)
        
        var title = UILabel(frame: CGMakeRect(170, 20, 100, 60))
        title.text = "登陆"
        headerBar.addSubview(title)
        
        var signupItem = UIButton(frame: CGMakeRect(300, 20, 100, 60))
        signupItem.setTitle("注册", forState: UIControlState.Normal)
        headerBar.addSubview(signupItem)
        
        headerBar.backgroundColor = UIColor.darkGrayColor()
        
        
        var  name = UITextField(frame: CGMakeRect(20, 200, 300, 60))
        name.text = "输入账户"
        self.view.addSubview(name)
        
        var pwd = UITextField(frame: CGMakeRect(20, 300, 300, 60))
        pwd.text = "输入密码"
        self.view.addSubview(pwd)
        
        
        
        var loginItem = UIButton(frame: CGMakeRect(180, 400, 60, 30))
        loginItem.backgroundColor = UIColor.grayColor()
        loginItem.setTitle("登陆", forState: UIControlState.Normal)
        loginItem.addTarget(self, action: "onLoginSeleted:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginItem)
        
        
        
        
        
        
        
        self.view.addSubview(headerBar)
        
    }
     func onLoginSeleted(sender:AnyObject?){
        
        
    }
    
    func onBackSeleted(sender:AnyObject?){
        
        println("onBackSeleted")
        
        var viewCtrl=AccessViewController()
        self.presentViewController(viewCtrl, animated: true, completion: nil)

    }
}
