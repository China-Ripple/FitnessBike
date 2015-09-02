//
//  RegisterViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/1.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    func layout(){
        
        
        var headerBar = UIView(frame: CGMakeRect(0, 0,375, 80))
        headerBar.backgroundColor = UIColor.grayColor()
        var backItem = UIButton(frame: CGMakeRect(20, 25, 35, 30))
        backItem.setImage(UIImage(named: "back"), forState:UIControlState.Normal)
        backItem.addTarget(self, action: "onBackSeleted:", forControlEvents: UIControlEvents.TouchUpInside)
        headerBar.addSubview(backItem)
        
        self.view.addSubview(headerBar)
        
        
        var name = UITextField(frame: CGMakeRect(20, 90, 375, 50))
        name.tintColor = UIColor.grayColor()
        name.placeholder = "请输入账号"
        self.view.addSubview(name)
        
        var line1 = UIView(frame: CGMakeRect(15, 150,350, 1))
        line1.backgroundColor = UIColor.grayColor()
        self.view.addSubview(line1)
        
        
        var checkNum = UITextField(frame: CGMakeRect(20, 160, 200, 50))
        checkNum.tintColor = UIColor.grayColor()
        checkNum.placeholder = "验证码"
        self.view.addSubview(checkNum)
        
        var getNum = UIButton(frame:CGMakeRect(210, 160, 100, 50))
        getNum.setBackgroundImage(UIImage(named: "checknum_bg"), forState: UIControlState.Normal)
        getNum.setTitle("发送", forState: UIControlState.Normal)
        getNum.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        self.view.addSubview(getNum)
        
        var line2 = UIView(frame: CGMakeRect(15, 220,200, 1))
        line2.backgroundColor = UIColor.grayColor()
        self.view.addSubview(line2)
        
        
        var psw = UITextField(frame: CGMakeRect(20, 230, 350, 50))
        psw.tintColor = UIColor.grayColor()
        psw.placeholder = "输入密码"
        self.view.addSubview(psw)
        
        var line3 = UIView(frame: CGMakeRect(15, 290,350, 1))
        line3.backgroundColor = UIColor.grayColor()
        self.view.addSubview(line3)
        
        
        var psw2 = UITextField(frame: CGMakeRect(20, 300, 350, 50))
        psw2.tintColor = UIColor.grayColor()
        psw2.placeholder = "再次输入密码"
        self.view.addSubview(psw2)
        
        var line4 = UIView(frame: CGMakeRect(15, 360,350, 1))
        line4.backgroundColor = UIColor.grayColor()
        self.view.addSubview(line4)
        

        
        var registerItem = UIButton(frame: CGMakeRect(40, 400, 300, 40))
        registerItem.setBackgroundImage(UIImage(named: "login_btn_bg"), forState: UIControlState.Normal)
        registerItem.setTitle("确认", forState: UIControlState.Normal)
        registerItem.addTarget(self, action: "onRegisterSeleted:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(registerItem)

        
        
       
        
        
    }
    func onRegisterSeleted(sender:AnyObject?){
        
        var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var viewCtrl:UITabBarController = storyboard.instantiateViewControllerWithIdentifier("mainCtrl") as! UITabBarController
        var mainVC=UINavigationController(rootViewController: UITableViewController())
        self.presentViewController(viewCtrl, animated: true, completion: nil)
        
    }
    
    func onBackSeleted(sender:AnyObject?){
        
        println("onBackSeleted")
        
        var viewCtrl=LoginViewController()
        self.presentViewController(viewCtrl, animated: true, completion: nil)
        
    }
}
