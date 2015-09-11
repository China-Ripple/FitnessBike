//
//  SearchTableViewCell.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/1.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import Alamofire
class SearchTableViewCell: UITableViewCell {

    var picture:UIImageView!
    var name:UILabel!
    var add2Contact:UIButton!
    var userId:Int!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        picture = UIImageView(frame: CGMakeRect(25,5,60,60))
        picture.image = UIImage(named: "profile")
        picture.layer.cornerRadius = picture.frame.size.width/2
        picture.clipsToBounds = true
        self.addSubview(picture)
        
        
        
        name = UILabel(frame: CGMakeRect(30,70,200,40))
        self.addSubview(name)
        
        add2Contact = UIButton(frame: CGMakeRect(250, 30, 100, 60))
        add2Contact.setTitle("添加", forState: UIControlState.Normal)
        add2Contact.backgroundColor = UIColor.grayColor()
        add2Contact.addTarget(self, action: "sendRequest:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(add2Contact)
        
    }
    
    
    func sendRequest(sender:AnyObject?){
        
        request()
       
    }
    
    
    func request(){
        
        Alamofire.request(Router.Makefriends(account: "\(userId)")).responseJSON{
            (_,_,json,error) in
            
            if error != nil {
                var alert = UIAlertView(title: "网络异常", message: "请检查网络设置", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                return
            }
            
            var result = JSON(json!)
            
            println("result: \(result)")
            
            if(result["response"].stringValue == "success"){
                
                
                
                let alert = UIAlertView()
                alert.title = "成功"
                alert.message = "用户id: \(self.userId)"
                alert.addButtonWithTitle("好的")
                alert.show()
                
            }
            else{
                var errMsg = result["error"]
                var errTxt = errMsg["text"].stringValue
                var alert = UIAlertView(title: "添加好友失败", message: "\(errTxt)", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }
        }
    }
    
    func makeCell(model:SearchModel){
        name.text = model.userName
        
        userId = model.userId
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
