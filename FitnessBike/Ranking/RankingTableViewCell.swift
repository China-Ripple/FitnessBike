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
        
        
        positionLabel = UILabel(frame: CGRectZero);
         self.contentView.addSubview(positionLabel);

        pictureImageView = UIImageView(frame:CGRectZero)
        pictureImageView.layer.cornerRadius = pictureImageView.frame.size.width/2
        pictureImageView.clipsToBounds = true
        self.contentView.addSubview(pictureImageView)
//
        name = UILabel(frame:CGRectZero)
        self.contentView.addSubview(name)
//
        awardImageView = UIImageView(frame:CGRectZero)
        self.contentView.addSubview(awardImageView)
      
        
        
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
        
        positionLabel.frame = CGRectMake(40, 30, 30, 30)
       
        
        pictureImageView.frame =  CGRectMake(65, 10, 40, 40)
       
        
        name.frame =  CGRectMake(65, 60, 100, 30)
        
        
        awardImageView.frame =  CGRectMake(20,30,30,50)
        
    }
}
