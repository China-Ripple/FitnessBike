//
//  RankingTableViewCell.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/21.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

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
        
        
        positionLabel = UILabel(frame: CGRectMake(40, 10, 30, 30));
        self.addSubview(positionLabel);

        pictureImageView = UIImageView(frame: CGRectMake(65, 10, 40, 40))
        self.addSubview(pictureImageView)
//
        name = UILabel(frame: CGRectMake(65, 60, 100, 30))
        self.addSubview(name)
//
        awardImageView = UIImageView(frame: CGRectMake(20,10,30,50))

        self.addSubview(awardImageView)
        
        
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
              self.addSubview(awardImageView)
              positionLabel.removeFromSuperview()
              awardImageView.image = a
        }
        else{
            awardImageView.removeFromSuperview()
            positionLabel.text = "\(model.position)"
        }
        
      
        
        var profile = UIImage(named: "nzt")
        pictureImageView.layer.cornerRadius = pictureImageView.frame.size.width/2
        pictureImageView.clipsToBounds = true
        pictureImageView.image = profile
        
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
    
     override func drawRect(rect: CGRect) {
        var ctx:CGContextRef = UIGraphicsGetCurrentContext();
        CGContextAddEllipseInRect(ctx, rect);
        CGContextSetFillColor(ctx, CGColorGetComponents(indicatorColor.CGColor));
        CGContextFillPath(ctx);
    
        if (innerColor != nil) {
            var innerSize:CGFloat = rect.size.width * 0.5;
            var innerRect:CGRect = CGRectMake(rect.origin.x + rect.size.width * 0.5 - innerSize * 0.5,
            rect.origin.y + rect.size.height * 0.5 - innerSize * 0.5,
            innerSize, innerSize);
            CGContextAddEllipseInRect(ctx, innerRect);
            CGContextSetFillColor(ctx, CGColorGetComponents(innerColor!.CGColor));
            CGContextFillPath(ctx);
        }

    }

}
