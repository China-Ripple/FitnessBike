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
        
        picture = UIImageView()
        picture.image = UIImage(named: "profile")
        picture.layer.cornerRadius = picture.frame.size.width/2
        picture.clipsToBounds = true
        self.addSubview(picture)
        picture.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.left.equalTo(self.snp_left).offset(10)
            make.top.equalTo(self.snp_top).offset(10)
        }
        
        
        
        
        name = UILabel()
        self.addSubview(name)
        name.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(60)
            make.left.equalTo(picture.snp_left)
            make.bottom.equalTo(self.snp_bottom).offset(10)
        }
        
        add2Contact = UIButton()
        add2Contact.setTitle("添加", forState: UIControlState.Normal)
        add2Contact.backgroundColor = UIColor.grayColor()
        add2Contact.addTarget(self, action: "sendRequest:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(add2Contact)
        add2Contact.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(70)
            make.height.equalTo(50)
            make.right.equalTo(self.snp_right).offset(-10)
            make.centerYWithinMargins.equalTo(self.snp_centerY)
        }

        
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
