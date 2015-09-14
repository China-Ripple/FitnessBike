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

    
    
    override func viewDidLoad() {
        
        
        
        
        
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        loadCompetition()
        
        loadPeople()
    
        
        
        
        
    }
    
   
    
    func loadPeople(){
        
        var peopleView = UIView(frame: CGRectMake(0, 100, UIScreen.mainScreen().bounds.size.width, 60));
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

        var speedView = UIButton(frame: CGRectMake(40, 10, 100, 100))
        var speed = UIImage(named: "speed_competition")
        speedView.setBackgroundImage(speed, forState: UIControlState.Normal)
        competitionView.addSubview(speedView)
        
        speedView.addTarget(self, action: "onSpeedCompetitionSelected:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        var speedTitle = UILabel(frame: CGRectMake(60,  120, 100, 50))
        speedTitle.text = "耐力之王"
        speedTitle.textColor = UIColor.lightGrayColor()
        competitionView.addSubview(speedTitle)
        
        var speedDes = UITextView(frame: CGRectMake(60,  160, 100, 50))
        speedDes.text = "   PK当日 \n最高里程数"
        speedDes.textColor = UIColor.lightGrayColor()
        competitionView.addSubview(speedDes)
        
        
        //===============================
        
        var staminaView = UIButton(frame: CGRectMake(180, 10, 100, 100))
        var stamina = UIImage(named: "stamina_competition")
        staminaView.setBackgroundImage(stamina, forState: UIControlState.Normal)
        staminaView.addTarget(self, action: "onStaminaCompetitionSelected:", forControlEvents: UIControlEvents.TouchUpInside)
        competitionView.addSubview(staminaView)
        
        
        var staminaTitle = UILabel(frame: CGRectMake(200,  120, 100, 50))
        staminaTitle.text = "竞速冠军"
        staminaTitle.textColor = UIColor.lightGrayColor()
        competitionView.addSubview(staminaTitle)
        
        var staminaDes = UITextView(frame: CGRectMake(200,  160, 100, 50))
        staminaDes.text = " PK一分钟内 \n最高燃烧量"
        staminaDes.textColor = UIColor.lightGrayColor()
        competitionView.addSubview(staminaDes)

        
        self.view.addSubview(competitionView)

    }
}
