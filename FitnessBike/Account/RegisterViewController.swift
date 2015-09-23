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
    let alertPicker:AlertPickerViewController=AlertPickerViewController()
    var weight:[String]=[String]()
    var weightTF = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        self.view.backgroundColor = UIColor.whiteColor()
        alertPicker.delegate = self
        alertPicker.dataSource = self
        alertPicker.mUIViewController=self
        alertPicker.mViewControllerDelegate=self
        
        for i in 10...105 {
            weight.append("\(i) 千克")
        }
        layout()
        
        
    }
    
    func layout(){
        
        
        
        
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
        
        
        
        
        weightTF.addTarget(self, action: "selectWeight:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(weightTF)
        weightTF.placeholder = "请输入体重"
        weightTF.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(line4).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(320)
            make.left.equalTo(line4.snp_left)
            
        }
        //        // add gesture
        //        let tapGesture = UITapGestureRecognizer(target: self, action: "selectWeight:")
        //        tapGesture.numberOfTouchesRequired = 1
        //        weightTF.addGestureRecognizer(tapGesture)
        
        var line5 = UIView(frame: CGMakeRect(15, 360,350, 1))
        line5.backgroundColor = UIColor.grayColor()
        self.view.addSubview(line5)
        line5.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(weightTF.snp_bottom).offset(2)
            make.height.equalTo(1)
            make.width.equalTo(320)
            make.left.equalTo(weightTF.snp_left)
        }
        
        
        
        registerItem = UIButton()
        registerItem.setBackgroundImage(UIImage(named: "login_btn_bg"), forState: UIControlState.Normal)
        registerItem.setTitle("确认", forState: UIControlState.Normal)
        registerItem.addTarget(self, action: "onRegisterSeleted:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(registerItem)
        registerItem.snp_makeConstraints { (make) -> Void in
            
            make.bottom.equalTo(self.view.snp_bottom).offset(-80)
            make.height.equalTo(40)
            make.width.equalTo(200)
            
            make.centerXWithinMargins.equalTo(self.view.snp_centerX)
            
        }
        
        
        
        
        
        
        //
    }
    
    
    func selectWeight(sender:AnyObject?){
        
        alertPicker.showPickerInActionSheet(0)
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
        if(psw2.text != psw.text){
            Utility.showMsg("两次输入密码不一样")
            return
        }
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
        
        
        let params = ["account":loginname,"password":loginpass,"checknum":number]
        
        
        
        
        
        Alamofire.request(Router.SignUp(parameters: params))
            .responseJSON { (request, response, json, error) in
                
                
                
                self.clearAllNotice()
                
                self.registerItem.enabled  = true
                self.registerItem.setTitle("注册", forState: UIControlState.allZeros)
                if error != nil {
                    
                    var alert = UIAlertView(title: "网络异常", message: "请检查网络设置", delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                    return
                }
                
                var result = JSON(json!)
                
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
        
        //println("onBackSeleted")
        
        //var viewCtrl=LoginViewController()
        //  self.navigationController?.popToRootViewControllerAnimated(true)
        //self.presentViewController(viewCtrl, animated: true, completion: nil)
        
    }
}

extension RegisterViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    
    
    
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return weight.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if(pickerView.tag == 0){
            
            return "\(weight[row])"
        }
            
            //        else if(pickerView.tag == 1){
            //            return "\(self.age[row] )"
            //        } else if(pickerView.tag == 2){
            //
            //
            //            return "\(self.weight[row < self.weight.count ? row:(row-1)])kg"
            //
            //        }
            //        else if(pickerView.tag==3){
            //            return "\(self.height[row < self.height.count ? row:(row-1)])cm"
            //        }
        else  {
            
            return "";
            
        }
        
    }
    //
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        println("you selected the name: \(self.weight[row])")
        weightTF.text = "\(self.weight[row])"
        
    }
    
}

extension RegisterViewController:AlertPickerViewControllerDelegate{
    func didSelect(){
        
        //weightTF.text = "\(self.weight[row])"
        
        println("didSelect")
        
    }
    func didCancel()
    {
        println("didCancel")
    }
}


