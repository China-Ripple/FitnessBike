//
//  RankingTableViewCell.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/21.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
class RankingTableViewCell: MGSwipeTableCell {
    
    
    var rankingModel:RankingModel!
    var positionLabel:UILabel!
    var awardImageView:UIImageView!
    var pictureImageView:UIImageView!
    var name:UILabel!
    
    var  indicatorColor:UIColor = UIColor.whiteColor();
    var innerColor:UIColor?;
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
//        positionLabel = UILabel(frame: CGRectZero);
        positionLabel = UILabel()
        self.contentView.addSubview(positionLabel);
        
//        pictureImageView = UIImageView(frame:CGRectZero)
        pictureImageView = UIImageView()
        pictureImageView.layer.cornerRadius = pictureImageView.frame.size.width/2
        pictureImageView.clipsToBounds = true
        self.contentView.addSubview(pictureImageView)
        pictureImageView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView.snp_left).offset(80)
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.centerYWithinMargins.equalTo(self.contentView)
        }
        
        
        //
//        name = UILabel(frame:CGRectZero)
        name = UILabel()
        self.contentView.addSubview(name)
        name.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.pictureImageView.snp_top)
            make.left.equalTo(self.pictureImageView.snp_right).offset(20)
//            make.width.equalTo(100)
//            make.height.equalTo(50)
        }
        //
//        awardImageView = UIImageView(frame:CGRectZero)
         awardImageView = UIImageView()
        self.contentView.addSubview(awardImageView)
        awardImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp_top).offset(20)
            make.left.equalTo(self.contentView.snp_left).offset(35.5)
            
            make.centerYWithinMargins.equalTo(awardImageView)
            make.top.equalTo(self.contentView.snp_bottom).offset(20)
            
        }
        
        
        
        //silver
        //3rdplace
        
    }
    
    func fillCell(model:RankingModel){
        
        var award:UIImage!
        
        if(model.position == 1){
            award = UIImage(named: "champion")
        }
        else if(model.position == 2){
            award = UIImage(named: "silver")
        }
        else if(model.position == 3){
            award = UIImage(named: "3rdplace")
        }
        
        if let a = award {
            
            
            self.contentView.addSubview(awardImageView)
            positionLabel.removeFromSuperview()
            awardImageView.image = a
            awardImageView.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(self.contentView.snp_top).offset(20)
                make.left.equalTo(self.contentView.snp_left).offset(35.5)
                
                make.centerYWithinMargins.equalTo(awardImageView)
                make.top.equalTo(self.contentView.snp_bottom).offset(20)
                
            }
            
            
        }
        else{
            awardImageView.removeFromSuperview()
            positionLabel.text = "\(model.position)"
        }
        
        
        let imageURL = "http://wx.qlogo.cn/mmopen/NtThuQzv5NKgyM1tSJG3JxjgYejtB3QBOxJhudndRaA3WdowvezqFsszBu2ibP0FgBsaV0icKpwBFGicevuuv08vMq2zadqhr7ic/0"
        
        //model.imageUrl
        
        //        Alamofire.request(.GET, imageURL).response() {
        //            (_, _, data, _) in
        //
        //            let image = UIImage(data: data! as! NSData)
        //
        //
        //
        //            self.pictureImageView.image = image
        //        }
        //
        
        self.pictureImageView.kf_setImageWithURL(NSURL(string:imageURL )!, placeholderImage: nil)
        
        
        self.name.text = model.name
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
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        //        positionLabel.frame = CGRectMake(40, 30, 30, 30)
        
        
        //        pictureImageView.frame =  CGRectMake(65, 10, 40, 40)
        
        
        //        name.frame =  CGRectMake(65, 60, 100, 30)
        //        
        //        
        //        awardImageView.frame =  CGRectMake(20,30,30,50)
        
    }
}
