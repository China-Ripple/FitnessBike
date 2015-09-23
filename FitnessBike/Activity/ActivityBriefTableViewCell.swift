//
//  ActivityBriefTableViewCell.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/17.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class ActivityBriefTableViewCell: UITableViewCell {
 
//    var imgView:UIImageView!
//    var titleLabel:UILabel!
//    var subTitleLabel:UILabel!
    var bgView:UIView!;
    var activityImageView:UIImageView!;
    var activityTitle:UILabel!;
    var activityTime:UILabel!;
    
    var activityRule:UILabel!;
    var activityNum1:UILabel!;
    var activityNum2:UILabel!;
    
    var activityWantJoinNum:UILabel!;
    var activityWantJoin:UILabel!;
    
    var activityAleadyJoinNum:UILabel!;
    var activityAleadyJoin:UILabel!;
    var activitySignUp:UIButton!;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
      
        self.backgroundColor = UIColor(hexString: "21262c")
        
        initTopViews();
        
        initCenterViews();
        
        initBottomViews();
        
        addToView();
        
        // 我要报名 按钮
        activitySignUp.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(UIScreen.mainScreen().bounds.width / 5 * 3)
            make.height.equalTo(30)
            make.centerXWithinMargins.equalTo(bgView);
            make.bottom.equalTo(bgView.snp_bottom).offset(-20)
        }

        
        // 为已报名人数 设置约束
        activityAleadyJoinNum.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(50);
            make.height.equalTo(30);
            make.top.equalTo(activityNum2).offset(35);
            make.right.equalTo(bgView.snp_right).offset(-30);
        }
        
        // 为已报名 设置约束
        activityAleadyJoin.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(50);
            make.height.equalTo(20);
            make.top.equalTo(activityAleadyJoinNum.snp_bottom);
            make.right.equalTo(bgView.snp_right).offset(-30);
            //make.centerXWithinMargins.equalTo(activityAleadyJoinNum.snp_center);
        }

        
        // 为想参加的人数 设置约束
        activityWantJoinNum.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.top.equalTo(activityNum2).offset(35);
            make.left.equalTo(bgView.snp_left).offset(30);
        }
        
        // 为想参加 设置约束
        activityWantJoin.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(50);
            make.height.equalTo(20);
            make.top.equalTo(activityWantJoinNum.snp_bottom);
            make.left.equalTo(bgView.snp_left).offset(30);
            //make.centerXWithinMargins.equalTo(activityWantJoinNum.snp_center);
        }
        
        // 为规则 2设置约束
        activityNum2.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(200);
            make.height.equalTo(15);
            make.top.equalTo(activityNum1.snp_bottom).offset(5);
            make.left.equalTo(bgView).offset(10);
        }
        
        // 为规则 1设置约束
        activityNum1.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(200);
            make.height.equalTo(15);
            make.top.equalTo(activityRule.snp_bottom).offset(10);
            make.left.equalTo(bgView).offset(10);
        }
        
        // 为比赛规则标题文本 设置约束
        activityRule.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(100);
            make.height.equalTo(15);
            make.top.equalTo(activityImageView.snp_bottom).offset(12);
            make.left.equalTo(bgView).offset(10);
        }
        
        // 为活动报名时间 设置约束
        activityTime.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(220);
            make.height.equalTo(30);
            make.bottom.equalTo(activityImageView.snp_bottom).offset(-12);
            make.left.equalTo(activityImageView.snp_left).offset(10);
        }
        
        // 为活动标题 设置约束
        activityTitle.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(220);
            make.height.equalTo(30);
            make.left.equalTo(activityImageView.snp_left).offset(10);
            make.bottom.equalTo(activityTime.snp_top).offset(10);
        }

        
//        // 为活动的主宣传图 设置约束
//        activityImageView.snp_makeConstraints { (make) -> Void in
//            make.width.equalTo(UIScreen.mainScreen().bounds.width / 8 * 7);
//            make.height.equalTo((UIScreen.mainScreen().bounds.height) / 5 * 3 / 2 - 10);
//            make.centerXWithinMargins.equalTo(bgView);
//            make.top.equalTo(bgView);
//            
////            activityImageView.layer.cornerRadius = 8
////            activityImageView.layer.masksToBounds = true
//            
//        
//        }
        
        
        var  maskPath:UIBezierPath = UIBezierPath(roundedRect: activityImageView.bounds, byRoundingCorners: UIRectCorner.TopLeft|UIRectCorner.TopRight, cornerRadii: CGSize(width: 8,height: 8))
        var maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = activityImageView.bounds;
        maskLayer.path = maskPath.CGPath;
        activityImageView.layer.mask = maskLayer;
        
        println("activityImageView: \(activityImageView.bounds),  self.frame.width:\( self.frame.width)")
        
        
        
        // 为最外层的视图容器设置约束
        bgView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(UIScreen.mainScreen().bounds.width / 8 * 7);
            make.height.equalTo((UIScreen.mainScreen().bounds.height) / 5 * 4 - 40);
            
            make.centerXWithinMargins.equalTo(self);
            make.centerYWithinMargins.equalTo(self);
        }
      
        
//        NSLog(@"----%d",self.frame.size.height / 5 * 4);
        
        
        
//        imgView = UIImageView(frame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2))
//        
//        self.addSubview(imgView)
//        
//        titleLabel = UILabel(frame: CGRectMake(20, self.frame.size.height*1/3, self.frame.size.width-20, 40))
//        
//        self.addSubview(titleLabel)
//        
//        
//        subTitleLabel =  UILabel(frame: CGRectMake(20, self.frame.size.height*1/3+40, self.frame.size.width-20, 20))
//        
//        self.addSubview(subTitleLabel)
    }
    
    func initBottomViews()
    {
        var font = UIFont.systemFontOfSize(10);
        var bigFont = UIFont.systemFontOfSize(20);
        
        // "想参加" 文本标题
        activityWantJoin = UILabel();
        activityWantJoin.text = "想参加";
        activityWantJoin.font = font;
        activityWantJoin.textAlignment = NSTextAlignment.Center;
        activityWantJoin.textColor = UIColor.grayColor();
        
        // "已参加" 文本标题
        activityAleadyJoin = UILabel();
        activityAleadyJoin.text = "已参加";
        activityAleadyJoin.font = font;
        activityAleadyJoin.textAlignment = NSTextAlignment.Center;
        activityWantJoin.textColor = UIColor.grayColor();
        
        // “想参加”  人数
        activityWantJoinNum = UILabel();
        activityWantJoinNum.text = "121"
        activityWantJoinNum.textColor = UIColor.blueColor();
        activityWantJoinNum.textAlignment = NSTextAlignment.Center;
        activityWantJoinNum.font = bigFont
        
        // “已参加”  人数
        activityAleadyJoinNum = UILabel();
        activityAleadyJoinNum.text = "121"
        activityAleadyJoinNum.textColor = UIColor.blueColor();
        activityAleadyJoinNum.textAlignment = NSTextAlignment.Center;
        activityAleadyJoinNum.font = bigFont
        
        // “我要报名按钮”
        activitySignUp = UIButton();
        activitySignUp.setTitle("我要报名", forState: UIControlState.Normal);
        activitySignUp.backgroundColor = UIColor.blueColor();
        activitySignUp.layer.masksToBounds = true;
        activitySignUp.layer.cornerRadius = 15;
    }
    
    func addToView()
    {
        // 添加到父视图中
        bgView.addSubview(activitySignUp);
        bgView.addSubview(activityWantJoin);
        bgView.addSubview(activityWantJoinNum);
        bgView.addSubview(activityAleadyJoin);
        bgView.addSubview(activityAleadyJoinNum);
        bgView.addSubview(activityRule);
        bgView.addSubview(activityNum1);
        bgView.addSubview(activityNum2);
        bgView.addSubview(activityImageView);
        bgView.addSubview(activityTitle);
        bgView.addSubview(activityTime);
        self.addSubview(bgView);
    }
    
    func initCenterViews()
    {
        var font = UIFont.systemFontOfSize(10);
        var font2 = UIFont.systemFontOfSize(12);
        
        // 活动规则 提示文本
        activityRule = UILabel();
        activityRule.text = "比赛规则";
        activityRule.font = font2;
        activityRule.textColor = UIColor.blueColor();
        
        // 活动规则 1
        activityNum1 = UILabel();
        activityNum1.text = "记录天数不少于10天 (少于10天)"
        activityNum1.font = font;
        
        // 活动规则 2
        activityNum2 = UILabel();
        activityNum2.text = "每天记录时间不超过1小事(超过1小事作废)";
        activityNum2.font = font;

    }
    
    func initTopViews()
    {
        var font = UIFont.systemFontOfSize(12);
        
        //生成最外层的容器视图
        bgView = UIView();
        //设置圆角
        bgView.layer.masksToBounds = true;
        bgView.layer.cornerRadius = 9;
        bgView.backgroundColor = UIColor.whiteColor();
        
        // 活动的主宣传图 视图
        activityImageView = UIImageView(frame: CGRectMake(0, 0, self.frame.width, 200));
        activityImageView.backgroundColor = UIColor.redColor()
        var activiyImage:UIImage! = UIImage(named: "activity.jpg")
        activityImageView.image = ImageUtil.scaleImage(CGSize(width: self.frame.width,height: 200), img:activiyImage);
        
        // 活动标题
        activityTitle = UILabel();
        activityTitle.text = "九月跑步机累计里程赛";
        activityTitle.textColor = UIColor.whiteColor();
        
        // 活动报名时间
        activityTime = UILabel();
        activityTime.text = "报名时间 8月10-8月31"
        activityTime.textColor = UIColor.whiteColor();
        activityTime.font = font;
    }
    
    func showActivity(model:ActivityBriefModel){
//        titleLabel.text = model.title
//        subTitleLabel.text = model.subTitle
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
