//
//  ImageUtil.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/14.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class ImageUtil: NSObject {
   
    class func scaleImage(image:UIImage,scaleSize:CGFloat)->UIImage
    {
    
        UIGraphicsBeginImageContext(image.size);
        
        // 绘制改变大小的图片
        image.drawInRect(CGRectMake(0, 0, scaleSize, scaleSize))
        
        // 从当前context中创建一个改变大小后的图片
        return UIGraphicsGetImageFromCurrentImageContext();
        
      
    
    }
}
