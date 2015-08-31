//
//  FriendRecommenderCollectionCell.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/31.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class FriendRecommenderCollectionCell: UICollectionViewCell {
    
    var pictureView:UIImageView!
    var nameLabel:UILabel!

 
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        pictureView = UIImageView(frame: CGMakeRect(0, 0, 30, 30))
        self.addSubview(pictureView)
        
        nameLabel = UILabel(frame: CGMakeRect(10,40,150,30))
        self.addSubview(nameLabel)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeCell(model:FriendModel){
        
        nameLabel.text = model.name
    }
    
    
}
