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
    
    
    class func scaleImage(size:CGSize,img:UIImage)->UIImage {
        
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(size);
        // 绘制改变大小的图片
        img.drawInRect(CGRectMake(0, 0, size.width, size.height));
        // 从当前context中创建一个改变大小后的图片
        var scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        // 返回新的改变大小后的图片
        return scaledImage;
        
    }
    

}
