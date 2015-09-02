//
//  ActivityBriefTableViewCell.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/17.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class ActivityBriefTableViewCell: UITableViewCell {
 
    var imgView:UIImageView!
    var titleLabel:UILabel!
    var subTitleLabel:UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgView = UIImageView(frame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2))
        
        self.addSubview(imgView)
        
        titleLabel = UILabel(frame: CGRectMake(20, self.frame.size.height*1/3, self.frame.size.width-20, 40))
        
        self.addSubview(titleLabel)
        
        
        subTitleLabel =  UILabel(frame: CGRectMake(20, self.frame.size.height*1/3+40, self.frame.size.width-20, 20))
        
        self.addSubview(subTitleLabel)
    }
    
    func showActivity(model:ActivityBriefModel){
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
    }
    
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
