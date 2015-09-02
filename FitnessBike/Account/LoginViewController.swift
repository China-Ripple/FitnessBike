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
        signupItem.addTarget(self, action: "onRegisterSeleted:", forControlEvents: UIControlEvents.TouchUpInside)
        headerBar.addSubview(signupItem)
        
        headerBar.backgroundColor = UIColor.darkGrayColor()
        
        var name = UITextField(frame: CGMakeRect(20, 90, 375, 50))
        name.tintColor = UIColor.grayColor()
        name.placeholder = "请输入账号"
        self.view.addSubview(name)
        
        var line1 = UIView(frame: CGMakeRect(15, 150,350, 1))
        line1.backgroundColor = UIColor.grayColor()
        self.view.addSubview(line1)
        
        
        var psw = UITextField(frame: CGMakeRect(20, 160, 350, 50))
        psw.tintColor = UIColor.grayColor()
        psw.placeholder = "请输入密码"
        self.view.addSubview(psw)
        
        var line2 = UIView(frame: CGMakeRect(15, 220,350, 1))
        line2.backgroundColor = UIColor.grayColor()
        self.view.addSubview(line2)
        
        
        
        
        var loginItem = UIButton(frame: CGMakeRect(40, 400, 300, 40))
        loginItem.setBackgroundImage(UIImage(named: "login_btn_bg"), forState: UIControlState.Normal)
        loginItem.setTitle("登陆", forState: UIControlState.Normal)
        loginItem.addTarget(self, action: "onLoginSeleted:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginItem)
        
        
        
        
        
        
        
        self.view.addSubview(headerBar)
        
    }
     func onLoginSeleted(sender:AnyObject?){
        
        
    }
    
    func onRegisterSeleted(sender:AnyObject?){
        var viewCtrl = RegisterViewController()
        self.presentViewController(viewCtrl, animated: true, completion: nil)
    }
    
    func onBackSeleted(sender:AnyObject?){
        
        println("onBackSeleted")
        
        var viewCtrl=AccessViewController()
        self.presentViewController(viewCtrl, animated: true, completion: nil)

    }
}
