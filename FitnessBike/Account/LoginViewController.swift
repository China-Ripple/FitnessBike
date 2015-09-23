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
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "登陆"
        layout()
        
        
        self.tabBarController?.tabBar.hidden = true
        
    }
    
    
    func layout(){
        
        
        
        var signupBtn = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Bordered, target: self, action: "onRegisterSeleted:")
        
        //  添加到到导航栏上
        self.navigationItem.rightBarButtonItem = signupBtn;
        
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
        
        
        
        
        
        
        
        //        self.view.addSubview(headerBar)
        
        
        
        
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {// called when 'return' key
        textField.resignFirstResponder()
        return true
    }
    
    private lazy var loginsKey: String? = {
        let key = "sqlcipher.key.logins.db"
        if KeychainWrapper.hasValueForKey(key) {
            return KeychainWrapper.stringForKey(key)
        }
        
        let Length: UInt = 256
        let secret = Bytes.generateRandomBytes(Length).base64EncodedString
        KeychainWrapper.setString(secret, forKey: key)
        return secret
        }()
    
    
    
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
                var prefs = NSUserDefaultsPrefs(prefix: "PrefsUserInfo")
                prefs.clearAll()
                prefs.setString(loginname, forKey: "user_account")
                prefs.setString(loginpass, forKey: "user_password")
                
                
                if let account = prefs.stringForKey("user_account"){
                    
                    println("saved key account : \(account)")
                }
                
                
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
        self.navigationController!.pushViewController(viewCtrl, animated: true)
        
        // self.presentViewController(viewCtrl, animated: true, completion: nil)
    }
    
    func onBackSeleted(sender:AnyObject?){
        
        println("onBackSeleted")
        
        var viewCtrl=AccessViewController()
        // self.presentViewController(viewCtrl, animated: true, completion: nil)
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
//    override func prefersStatusBarHidden() -> Bool {
//        self.navigationController!.setNavigationBarHidden(false
//            , animated: false)
//        
//        return false
//    }
    
    
}
