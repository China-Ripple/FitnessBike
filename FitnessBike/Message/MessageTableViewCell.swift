//
//  MessageTableViewCell.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/1.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    var refuseBtn:UIButton!
    var acceptBtn:UIButton!
    var titleLabel:UILabel!
    var matchImage:UIImageView!
    var matchName:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //        refuseBtn = UIButton(frame: CGMakeRect(5, 10, 100, 60))
        var  refuseBtn = UIButton()
        refuseBtn.setTitle("拒绝", forState: UIControlState.Normal)
        refuseBtn.addTarget(self, action: "refuse:", forControlEvents: UIControlEvents.TouchUpInside)
        refuseBtn.backgroundColor = UIColor.darkGrayColor()
        //         refuseBtn.backgroundColor = UIColor.redColor()
        self.addSubview(refuseBtn)
        refuseBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp_top).offset(10)
            make.left.equalTo(self.contentView.snp_left).offset(0)
            make.centerYWithinMargins.equalTo(self.contentView)
            make.width.equalTo(60)
            make.height.equalTo(40)
            
        }
        
        
        
        
        
        
        
        //        acceptBtn = UIButton(frame: CGMakeRect(300, 10, 80, 60))
        var acceptBtn = UIButton()
        acceptBtn.setTitle("接受", forState: UIControlState.Normal)
        acceptBtn.addTarget(self, action: "accept:", forControlEvents: UIControlEvents.TouchUpInside)
        acceptBtn.backgroundColor = UIColor.darkGrayColor()
        //        acceptBtn.backgroundColor = UIColor.redColor()
        self.addSubview(acceptBtn)
        acceptBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).offset(10)
            
            make.right.equalTo(self.snp_right).offset(0)
            make.centerYWithinMargins.equalTo(self.contentView)
            
            //            make.centerYWithinMargins.equalTo(self)
            
            
            
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        
        
        
        
        
        
        titleLabel = UILabel(frame: CGMakeRect(120, 5, 200, 40))
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont(name: "Arial", size: 15)
        self.addSubview(titleLabel)
        
        matchImage = UIImageView(frame: CGMakeRect(129, 50, 40, 40))
        self.addSubview(matchImage)
        
        matchName = UILabel(frame: CGMakeRect(140, 50, 100, 40))
        matchName.textColor = UIColor.whiteColor()
        self.addSubview(matchName)
        
        self.backgroundColor = UIColor.grayColor()
        
    }
        override func layoutSubviews() {
    
            super.layoutSubviews()
    
//            self.addSubview(refuseBtn)
//            self.addSubview(acceptBtn)
//            self.addSubview(matchName)
//            self.addSubview(matchImage)
//            self.addSubview(titleLabel)
    
        }
    
    
    
    
    
    func accept(sender:AnyObject?){
        let alert = UIAlertView()
        alert.title = "恭喜你"
        alert.message = "已经接受挑战，做好身体准备吧"
        alert.addButtonWithTitle("好的")
        alert.show()
    }
    
    func refuse(sender:AnyObject?){
        let alert = UIAlertView()
        alert.title = "遗憾"
        alert.message = "已经帮您拒绝对方的邀请"
        alert.addButtonWithTitle("好的")
        alert.show()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeCell(model:MessageModel){
        if(model.defierId == 0){
            
            matchName.text = "耐力之王"
            
        }
        else{
            matchName.text = "竞速冠军"
        }
        titleLabel.text = "\(model.defierName)发起了PK"
        matchName.snp_makeConstraints { (make) -> Void in
            //            make.left.equalTo(self.contentView.snp_left).offset(50)
            make.centerXWithinMargins.equalTo(self.contentView)
            make.bottom.equalTo(self.snp_bottom).offset(-10)
            
            
        }
        titleLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(self.snp_top).offset(15)
            
            make.centerXWithinMargins.equalTo(self.contentView)
        }
        
    }
    
}




