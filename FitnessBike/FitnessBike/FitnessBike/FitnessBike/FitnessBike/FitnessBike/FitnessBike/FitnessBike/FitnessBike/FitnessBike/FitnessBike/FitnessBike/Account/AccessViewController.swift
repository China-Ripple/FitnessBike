//
//  AccessViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/31.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class AccessViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
        self.view.backgroundColor = UIColor.grayColor()
        
    }
    
    func layout(){
        
        var proImage = UIImage(named: "rongtai_logo")
        
        var profileImgView = UIImageView(frame: CGMakeRect(150, 100, 80, 80))
        profileImgView.image = proImage
        profileImgView.layer.cornerRadius = profileImgView.frame.size.width/2
        
        profileImgView.clipsToBounds = true
        self.view.addSubview(profileImgView)
        
        
        var btnLogin = UIButton(frame: CGMakeRect(130, 200, 120, 60))
        btnLogin.setTitle("登陆、注册", forState: UIControlState.Normal)
        btnLogin.addTarget(self, action: "onLoginSelected:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnLogin)
        
        
        var thirdPartTitle = UILabel(frame: CGMakeRect(130, 200, 100, 60))
        self.view.addSubview(thirdPartTitle)
        
        
        var qqLogin = UIButton(frame: CGMakeRect(90, 400, 100, 60))
        qqLogin.setImage(UIImage(named: "qq"), forState: UIControlState.Normal)
        self.view.addSubview(qqLogin)

        var weixinLogin = UIButton(frame: CGMakeRect(200, 400, 100, 60))
        weixinLogin.setImage(UIImage(named: "weixin"), forState: UIControlState.Normal)
        self.view.addSubview(weixinLogin)
        
        
        var skipBtn = UIButton(frame: CGMakeRect(130, 500, 100, 60))
        skipBtn.setTitle("跳过", forState: UIControlState.Normal)
        skipBtn.addTarget(self, action: "onSkipSelected:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(skipBtn)

        
    }
    func onLoginSelected(sender:AnyObject?){
        println("onLoginSelected")
        
        var viewCtrl = LoginViewController()
        self.presentViewController(viewCtrl, animated: true, completion: nil)
        
    }
    
    func onSkipSelected(sender:AnyObject?){
        
        println("onSkipSelected")
        
        var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var viewCtrl:UITabBarController = storyboard.instantiateViewControllerWithIdentifier("mainCtrl") as! UITabBarController
        var mainVC=UINavigationController(rootViewController: UITableViewController())
        self.presentViewController(viewCtrl, animated: true, completion: nil)
    }
    
    
}
