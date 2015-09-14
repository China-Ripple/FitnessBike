//
//  RegisterViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/1.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import Alamofire
class RegisterViewController: UIViewController {

    var name:UITextField!
    var checkNum :UITextField!
    var psw :UITextField!
    var registerItem:UIButton!
    var psw2:UITextField!
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
        
        
        name = UITextField(frame: CGMakeRect(20, 90, 375, 50))
        name.tintColor = UIColor.grayColor()
        name.placeholder = "请输入账号"
        self.view.addSubview(name)
        
        var line1 = UIView(frame: CGMakeRect(15, 150,350, 1))
        line1.backgroundColor = UIColor.grayColor()
        self.view.addSubview(line1)
        
        
        checkNum = UITextField(frame: CGMakeRect(20, 160, 200, 50))
        checkNum.tintColor = UIColor.grayColor()
        checkNum.placeholder = "验证码"
        self.view.addSubview(checkNum)
        
        var getNum = UIButton(frame:CGMakeRect(210, 160, 100, 50))
        getNum.setBackgroundImage(UIImage(named: "checknum_bg"), forState: UIControlState.Normal)
        getNum.setTitle("获取", forState: UIControlState.Normal)
        getNum.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        self.view.addSubview(getNum)
        
        var line2 = UIView(frame: CGMakeRect(15, 220,200, 1))
        line2.backgroundColor = UIColor.grayColor()
        self.view.addSubview(line2)
        
        
        psw = UITextField(frame: CGMakeRect(20, 230, 350, 50))
        psw.tintColor = UIColor.grayColor()
        psw.placeholder = "输入密码"
        self.view.addSubview(psw)
        
        var line3 = UIView(frame: CGMakeRect(15, 290,350, 1))
        line3.backgroundColor = UIColor.grayColor()
        self.view.addSubview(line3)
        
        
        psw2 = UITextField(frame: CGMakeRect(20, 300, 350, 50))
        psw2.tintColor = UIColor.grayColor()
        psw2.placeholder = "再次输入密码"
        self.view.addSubview(psw2)
        
        var line4 = UIView(frame: CGMakeRect(15, 360,350, 1))
        line4.backgroundColor = UIColor.grayColor()
        self.view.addSubview(line4)
        

        
        registerItem = UIButton(frame: CGMakeRect(40, 400, 300, 40))
        registerItem.setBackgroundImage(UIImage(named: "login_btn_bg"), forState: UIControlState.Normal)
        registerItem.setTitle("确认", forState: UIControlState.Normal)
        registerItem.addTarget(self, action: "onRegisterSeleted:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(registerItem)

        
        
      //requesRegister()
        
        
    }
    
    func requesRegister(){
         let parameters = ["account":"bbbb","password":"cccc","checknum":"11111"]
//         Alamofire.request(.GET, "http://wx.rongtai-china.com/fitnessbike/signup", parameters: parameters, encoding: .JSON)
//            .responseJSON { (request, response, data, error) in
        
        Alamofire.request(Router.SignUp(parameters: parameters)).responseJSON{
            (_,_,json,error) in
        
            
                
                var result = JSON(json!)
             println("data: \(result)")
            
         }
    }
    func onRegisterSeleted(sender:AnyObject?){
        
//        
        if(name.text.isEmpty){
            Utility.showMsg("账号不能为空")
            return
        }
        if(psw.text.isEmpty){
            Utility.showMsg("密码不能为空")
            return
        }
        if(psw2.text.isEmpty){
            Utility.showMsg("请再次输入密码")
            return
        }
//        if(psw2.text != psw.text){
//            Utility.showMsg("两次输入密码不一样")
//            return
//        }
        if(checkNum.text.isEmpty){
            Utility.showMsg("验证码不能为空")
            return
        }
        
        
        var loginname = name.text
        var loginpass = psw.text
        var number = checkNum.text
        
        pleaseWait()
        
        name.enabled  = false
        psw.enabled = false
        registerItem.enabled = false
        registerItem.setTitle("注册ing...", forState: UIControlState.allZeros)
        

        
//         let params:[String:AnyObject] = ["account":name.text,"password":psw.text,"checknum":checkNum.text]
//
      

        let params = ["account":"zzzzd","password":"cccc","checknum":"11111"]
        
//        Alamofire.request(.GET, "http://wx.rongtai-china.com/fitnessbike/signup", parameters: params, encoding: .JSON)
        
        let req =  "http://wx.rongtai-china.com/fitnessbike/signup?account=\(loginname)&password=\(loginpass)&&checknum=\(number)"
            
        Alamofire.request(Router.SignUp(parameters: params)).responseJSON{
            (_,_,json,error) in
            
        


                    
            
            self.clearAllNotice()
            
            self.registerItem.enabled  = true
            self.registerItem.setTitle("注册", forState: UIControlState.allZeros)
            if error != nil {
                
                var alert = UIAlertView(title: "网络异常", message: "请检查网络设置", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                return
            }
            
            var result = JSON(json!)
            
            println("result :\(result)")
            
            if(result["response"].stringValue != "error"){
                
                var token = result["token"].stringValue
                KeychainWrapper.setString(token, forKey: "token")
                Router.token  = token
                
                Utility.enterMainScreen(self)
            }
            else{
                var errMsg = result["error"]
                
                var errTxt = errMsg["text"].stringValue
                
                
                var alert = UIAlertView(title: "注册失败", message: "\(errTxt)", delegate: nil, cancelButtonTitle: "确定")
                
                alert.show()
            }
        }
        
    }
    
    func onBackSeleted(sender:AnyObject?){
        
        println("onBackSeleted")
        
        var viewCtrl=LoginViewController()
        self.presentViewController(viewCtrl, animated: true, completion: nil)
        
    }
}
