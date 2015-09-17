//
//  CompetitionViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/27.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import Alamofire
class CompetitionViewController: UIViewController {

    var peopleView:UIView!;
    var paddingTop:CGFloat!;

    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.whiteColor()
        paddingTop = self.navigationController!.navigationBar.frame.height + Utility.getStatusHeight()
        
        loadPeople()
        loadCompetition()
    }
    
   
    
    func loadPeople(){
        
        peopleView = UIView(frame: CGRectMake(0, 100, UIScreen.mainScreen().bounds.size.width, 60));
        peopleView.backgroundColor = UIColor.darkGrayColor()
        
        
        var oneView = UIImageView(frame: CGRectMake(100, 10, 40, 40))
        var one = UIImage(named: "nzt")
        oneView.image = one
        oneView.layer.cornerRadius = oneView.frame.size.width/2
        oneView.clipsToBounds = true
        peopleView.addSubview(oneView)
        
        var pkView = UIImageView(frame: CGRectMake(150, 10, 40, 40))
        var pk = UIImage(named: "pk")
        pkView.image = pk
        pkView.layer.cornerRadius = pkView.frame.size.width/2
        pkView.clipsToBounds = true
        peopleView.addSubview(pkView)
        
        
        var anotherView = UIImageView(frame: CGRectMake(200, 10, 40, 40))
        var another = UIImage(named: "bike_image")
        anotherView.image = another
        peopleView.addSubview(anotherView)
        
        self.view.addSubview(peopleView)
        
        // 为顶部栏两人的头像和中间PK图标的视图容器设置位置
        
        peopleView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(UIScreen.mainScreen().bounds.size.width)
            make.height.equalTo(60);
            make.top.equalTo(paddingTop);
        }
        
    }
    
    func sendRequest(defenderid:String,type:Int,time:String){
        
        Alamofire.request(Router.Competition(defenderid: defenderid, type: type, time: time)).responseJSON{
            (_,_,json,error) in

            if error != nil {
                var alert = UIAlertView(title: "网络异常", message: "请检查网络设置", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                return
            }
            
            var result = JSON(json!)
            
            println("result: \(result)")
            
            if(result["response"].stringValue == "success"){
                
                let alert = UIAlertView()
                alert.title = "成功"
                alert.message = "请求成功,请做好竞赛准备"
                alert.addButtonWithTitle("好的")
                alert.show()

                
            }
            else{
                var errMsg = result["error"]
                var errTxt = errMsg["text"].stringValue
                var alert = UIAlertView(title: "请求失败", message: "\(errTxt)", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }
        }

    }
    
    func onSpeedCompetitionSelected(send:AnyObject?)
    {

       sendRequest("11111",type: 1,time: "2015-10-15")

    }
    func onStaminaCompetitionSelected(send:AnyObject?){
        
       sendRequest("22222",type: 1,time: "2015-10-15")
    }
    
    
    func loadCompetition(){
        var competitionView = UIView(frame: CGRectMake(0, 200, UIScreen.mainScreen().bounds.size.width, 60));

        //
        var speedView = UIButton()//(frame: CGRectMake(40, 10, 100, 100))
        var speed = UIImage(named: "speed_competition")
        speedView.setBackgroundImage(speed, forState: UIControlState.Normal)
        competitionView.addSubview(speedView)
        
        speedView.addTarget(self, action: "onSpeedCompetitionSelected:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        var speedTitle = UILabel()//(frame: CGRectMake(60,  120, 100, 50))
        speedTitle.text = "耐力之王"
        speedTitle.textColor = UIColor.lightGrayColor()
        competitionView.addSubview(speedTitle)
        
        var speedDes = UITextView()//(frame: CGRectMake(60,  160, 100, 50))
        speedDes.text = "   PK当日 \n最高里程数"
        speedDes.textColor = UIColor.lightGrayColor()
        competitionView.addSubview(speedDes)
        
        
        //===============================
        
        var staminaView = UIButton()//(frame: CGRectMake(180, 10, 100, 100))
        var stamina = UIImage(named: "stamina_competition")
        staminaView.setBackgroundImage(stamina, forState: UIControlState.Normal)
        staminaView.addTarget(self, action: "onStaminaCompetitionSelected:", forControlEvents: UIControlEvents.TouchUpInside)
        competitionView.addSubview(staminaView)
        
        
        var staminaTitle = UILabel()
        staminaTitle.text = "竞速冠军"
        staminaTitle.textColor = UIColor.lightGrayColor()
        competitionView.addSubview(staminaTitle)
        
        var staminaDes = UITextView()//(frame: CGRectMake(200,  160, 100, 50))
        staminaDes.text = " PK一分钟内 \n最高燃烧量"
        staminaDes.textColor = UIColor.lightGrayColor()
        competitionView.addSubview(staminaDes)

        
        self.view.addSubview(competitionView)
        
        // 耐力之王图标
        speedView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(120);
            make.height.equalTo(120);
            make.top.equalTo(peopleView).offset(peopleView.frame.height * 2);//.frame.height+paddingTop+20);
            make.left.equalTo(competitionView.snp_left).offset(self.view.frame.width/16);
        }
        
        // 竞速之王图标
        staminaView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(120);
            make.height.equalTo(120);
            make.top.equalTo(peopleView).offset(peopleView.frame.height * 2);//.frame.height+paddingTop+20);
            make.right.equalTo(competitionView.snp_right).offset(-self.view.frame.width/16);
        }
        
        //文本居中
        speedTitle.textAlignment = NSTextAlignment.Center
        // 耐力之王文本
        speedTitle.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(100);
            make.height.equalTo(50);

            make.top.equalTo(speedView.snp_bottom).offset(10);
            make.centerXWithinMargins.equalTo(speedView.snp_centerX);
        }

        speedDes.textAlignment = NSTextAlignment.Center
        // 耐力之王描述
        speedDes.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(100);
            make.height.equalTo(50);

            make.top.equalTo(speedTitle.snp_bottom).offset(10);
            make.centerXWithinMargins.equalTo(speedView.snp_centerX);
        }

        staminaTitle.textAlignment = NSTextAlignment.Center
        // 竞速之王文本
        staminaTitle.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(100);
            make.height.equalTo(50);

            make.top.equalTo(staminaView.snp_bottom).offset(10);
            make.centerXWithinMargins.equalTo(staminaView.snp_centerX);
        }
        
        staminaDes.textAlignment = NSTextAlignment.Center
        // 竞速之王描述
        staminaDes.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(100);
            make.height.equalTo(50);
            make.top.equalTo(staminaTitle.snp_bottom).offset(10);
            make.centerXWithinMargins.equalTo(staminaView.snp_centerX);
        }

    }
}
