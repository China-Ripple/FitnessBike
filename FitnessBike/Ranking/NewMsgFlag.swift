//
//  NewMsgFlag.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/21.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class NewMsgFlag: UIView {

    
    var  _indicatorColor = UIColor(hexString: "#ff0000")
    var _innerColor = UIColor(hexString: "#334455")

    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        var ctx:CGContextRef = UIGraphicsGetCurrentContext();
        CGContextAddEllipseInRect(ctx, rect);
        CGContextSetFillColor(ctx, CGColorGetComponents(_indicatorColor!.CGColor));
        CGContextFillPath(ctx);
        
//        if (_innerColor != nil) {
//            var innerSize:CGFloat = rect.size.width * 0.5;
//            var innerRect:CGRect = CGRectMake(rect.origin.x + rect.size.width * 0.5 - innerSize * 0.5,
//                rect.origin.y + rect.size.height * 0.5 - innerSize * 0.5,
//                innerSize, innerSize);
//            CGContextAddEllipseInRect(ctx, innerRect);
//            CGContextSetFillColor(ctx, CGColorGetComponents(_innerColor!.CGColor));
//            CGContextFillPath(ctx);
//        }


    
    }


}
