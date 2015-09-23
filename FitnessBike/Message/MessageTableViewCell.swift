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
    var defier:UILabel!
    var titleLabel:UILabel!
    var matchLabel:UILabel!
    var matchImage:UIImageView!
    var matchName:UILabel!
    var matchImg:UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        refuseBtn = UIButton()
        refuseBtn.setTitle("拒绝", forState: UIControlState.Normal)
        refuseBtn.titleLabel?.textColor = UIColor.redColor()
        refuseBtn.addTarget(self, action: "refuse:", forControlEvents: UIControlEvents.TouchUpInside)
        refuseBtn.setBackgroundImage(UIImage(named: "btn_right"), forState: UIControlState.allZeros)
        self.addSubview(refuseBtn)
        refuseBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left).offset(0)
            make.centerYWithinMargins.equalTo(self.snp_centerY)
            make.width.equalTo(60)
            make.height.equalTo(40)
            
        }
      
        
        acceptBtn = UIButton()
        acceptBtn.setTitle("接受", forState: UIControlState.Normal)
        acceptBtn.setBackgroundImage(UIImage(named: "btn_left"), forState: UIControlState.allZeros)
        acceptBtn.addTarget(self, action: "accept:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(acceptBtn)
        acceptBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self.snp_right).offset(0)
            make.centerYWithinMargins.equalTo(self.contentView)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        

        
        defier = UILabel()
        defier.textColor = UIColor(hexString: "#0099e2")
        defier.font = UIFont(name: "Arial", size: 15)
        self.addSubview(defier)
    
        
        titleLabel = UILabel()
        titleLabel.text = "发起了"
        titleLabel.textColor = UIColor(hexString: "#003355")
        titleLabel.font = UIFont(name: "Arial", size: 15)
        self.addSubview(titleLabel)
        
        matchLabel = UILabel()
        matchLabel.textColor = UIColor.blueColor()
        matchLabel.text = "pk"
        matchLabel.font = UIFont(name: "Arial", size: 15)
        self.addSubview(matchLabel)
        
        matchImage = UIImageView(frame: CGMakeRect(129, 50, 40, 40))
        self.addSubview(matchImage)
       
        

        matchName = UILabel(frame: CGMakeRect(140, 50, 100, 40))
        matchName.textColor = UIColor(hexString: "#21262c")
        self.addSubview(matchName)
        
       
        
        matchName.snp_makeConstraints { (make) -> Void in
            make.centerXWithinMargins.equalTo(self.contentView)
            make.bottom.equalTo(self.snp_bottom).offset(-10)
            
            
        }
        
        matchLabel.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(self.titleLabel.snp_right).offset(10)
            make.bottom.top.equalTo(titleLabel)
            
            
        }

        defier.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(self.snp_top).offset(15)
            make.right.equalTo(titleLabel.snp_left).offset(-10)
        }

        titleLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(defier.snp_top)
            make.centerXWithinMargins.equalTo(self.snp_centerX)
            make.width.height.equalTo(defier)
        }
        matchImage.snp_makeConstraints { (make) -> Void in
            
            make.right.equalTo(matchName.snp_left).offset(-10)
            make.top.equalTo(matchName)
            make.bottom.equalTo(matchName)
            make.height.equalTo(matchName)
            
        }
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
        var scale:CGFloat = 0.5
        if(model.defierId == 0){
            var img:UIImage! = UIImage(named: "stamina_flag")
            matchImage.image =  ImageUtil.scaleImage(CGSizeMake(img!.size.width*scale, img.size.height*scale), img:img)
            matchName.text = "耐力之王"
            
        }
        else if(model.defierId == 1){
            var img:UIImage! = UIImage(named: "speed_flag")
            matchImage.image =  ImageUtil.scaleImage(CGSizeMake(img!.size.width*scale, img.size.height*scale), img:img)
            matchName.text = "竞速冠军"
        }
        else if(model.defierId == 2){
            var img:UIImage! = UIImage(named: "stamina_flag")
            matchImage.image =  ImageUtil.scaleImage(CGSizeMake(img!.size.width*scale, img.size.height*scale), img:img)
            matchLabel.text = "好友申请"
            matchName.text = "我很崇拜你"
        }
        else{
            var img:UIImage! = UIImage(named: "speed_flag")
            matchImage.image =  ImageUtil.scaleImage(CGSizeMake(img!.size.width*scale, img.size.height*scale), img:img)
            matchLabel.text = "约会"
            matchName.text = "海天盛筵"
        }
       
        defier.text = "\(model.defierName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))"
        

    }
    
}




