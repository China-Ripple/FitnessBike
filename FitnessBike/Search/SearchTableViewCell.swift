//
//  SearchTableViewCell.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/1.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    var picture:UIImageView!
    var name:UILabel!
    var add2Contact:UIButton!
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
        let alert = UIAlertView()
        alert.title = "成功"
        alert.message = "已经将您的请求发送到对方，耐心等待回复"
        alert.addButtonWithTitle("好的")
        alert.show()
    }
    
    func makeCell(model:SearchModel){
        name.text = model.userName
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
