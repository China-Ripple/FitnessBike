//
//  LoginViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/31.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import Alamofire
class LoginViewController: UIViewController ,UITextFieldDelegate{
    
    var name:UITextField!
    var psw:UITextField!
    var loginItem:UIButton!
    
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
        
        name = UITextField(frame: CGMakeRect(20, 90, 375, 50))
        name.tintColor = UIColor.grayColor()
        name.placeholder = "请输入账号"
        name.delegate = self
        self.view.addSubview(name)
        
        var line1 = UIView(frame: CGMakeRect(15, 150,350, 1))
        line1.backgroundColor = UIColor.grayColor()
        self.view.addSubview(line1)
        
        
        psw = UITextField(frame: CGMakeRect(20, 160, 350, 50))
        psw.tintColor = UIColor.grayColor()
        psw.placeholder = "请输入密码"
        self.view.addSubview(psw)
        
        var line2 = UIView(frame: CGMakeRect(15, 220,350, 1))
        line2.backgroundColor = UIColor.grayColor()
        self.view.addSubview(line2)
        
        
        
        
        loginItem = UIButton(frame: CGMakeRect(40, 400, 300, 40))
        loginItem.setBackgroundImage(UIImage(named: "login_btn_bg"), forState: UIControlState.Normal)
        loginItem.setTitle("登陆", forState: UIControlState.Normal)
        loginItem.addTarget(self, action: "onLoginSeleted:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginItem)
        
        
        
        
        
        
        
        self.view.addSubview(headerBar)
        
     
        
        
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {// called when 'return' key
        textField.resignFirstResponder()
        return true
    }
     func onLoginSeleted(sender:AnyObject?){
        
//        
        if(name.text.isEmpty){
            Utility.showMsg("账号不能为空")
            return
        }
        if(psw.text.isEmpty){
            Utility.showMsg("密码不能为空")
            return
        }

        var loginname = name.text
        var loginpass = psw.text
        
        pleaseWait()
        
        name.enabled  = false
        psw.enabled = false
        loginItem.enabled = false
        loginItem.setTitle("登录ing...", forState: UIControlState.allZeros)
        
        
        println("account=\(loginname) psw=\(loginpass)")
        
        Alamofire.request(Router.SignIn(account: loginname, password: loginpass)).responseJSON{
            (_,_,json,error) in
            
            self.clearAllNotice()
            
            self.loginItem.enabled  = true
            self.loginItem.setTitle("登录", forState: UIControlState.allZeros)
            if error != nil {
                
                var alert = UIAlertView(title: "网络异常", message: "请检查网络设置", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                return
            }
            
             var result = JSON(json!)
            
            println("result: \(result)")
            
            if(result["response"].stringValue != "error"){
                
                var token = result["token"].stringValue
                KeychainWrapper.setString(token, forKey: "token")
                Router.token  = token
                Utility.enterMainScreen(self)
                
            }
            else{
                var errMsg = result["error"]
                var errTxt = errMsg["text"].stringValue
                var alert = UIAlertView(title: "登录失败", message: "\(errTxt)", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }
        }


        
        
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
