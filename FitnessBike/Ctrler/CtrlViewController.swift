//
//  CtrlViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/14.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit


class CtrlViewController: UIViewController {

//    var paddingTop = self.navigationController!.navigationBar.frame.height + Utility.getStatusHeight()

    let imageSize:CGFloat = 200
    let imageOffsetX:CGFloat = 60
    let imageOffsetY:CGFloat = 100
    var scrollView:UIScrollView!
    var pageCtrl:UIPageControl!
    var shareButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
      //  var bleService = MyBleService.getInstance()
        
        shareButton = UIButton(frame: CGRectMake(15, 30, 18, 18))
        shareButton.setImage(UIImage(named: "share"), forState: UIControlState.Normal)
        self.view.addSubview(shareButton)
        
        
        layoutScrollPage()
        layoutDataView()
        
        
       var ble =  MyBleService.getInstance()
        
    }
    
    func layoutScrollPage(){
        scrollView = UIScrollView();//frame:CGRectMake(imageOffsetX,imageOffsetY,imageSize,imageSize))
        //scrollView.backgroundColor = UIColor.grayColor()
        scrollView.pagingEnabled=true
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.showsVerticalScrollIndicator=false
        scrollView.delegate = self
        
        var bikeImage = UIImage(named: "bike_image")
        //var bikeScaledImage = ImageUtil.scaleImage(bikeImage!,scaleSize:imageSize)
        
        var bikeImageView = UIImageView(image:bikeImage)
        bikeImageView.frame = CGRectMake(0, 0, imageSize, imageSize)
        scrollView.addSubview(bikeImageView)
        
        var dataImage = UIImage(named: "data_image")
        
        var dataImageView = UIImageView(image:dataImage)
        dataImageView.frame = CGRectMake(imageSize, 0, imageSize, imageSize)
        scrollView.addSubview(dataImageView)
        
        
        scrollView.contentSize = CGSizeMake(imageSize*2, imageSize)
        scrollView.indicatorStyle = UIScrollViewIndicatorStyle.White
        
        
        self.view.addSubview(scrollView)
        
        // 滑动
        scrollView.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(200);
            make.top.equalTo(self.view.frame.size.height / 4);
            make.centerXWithinMargins.equalTo(self.view.snp_centerX);
        }
//        
//        bikeImageView.snp_makeConstraints { (make) -> Void in
//            make.width.height.equalTo(imageSize);
//            make.top.equalTo(scrollView).offset(20);
//            make.left.equalTo(<#other: Float#>)
//        }
//        
//        dataImageView.snp_makeConstraints { (make) -> Void in
//            make.width.height.equalTo(imageSize);
//            make.top.equalTo(scrollView).offset(20);
//        }

        
        self.view.backgroundColor = UIColor.darkGrayColor()
        
        
        pageCtrl = UIPageControl(frame:CGRectMake(imageOffsetX, imageOffsetY+imageSize+10, imageSize, 60))
        
        self.view.addSubview(pageCtrl)
        
        pageCtrl.numberOfPages = 2
        pageCtrl.currentPage = 0
        pageCtrl.addTarget(self, action: "pageTurn:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func pageTurn(sender:AnyObject?){
        var pageCtrl = sender as! UIPageControl
        
        var index = pageCtrl.currentPage
        
        scrollView.contentOffset = CGPointMake(CGFloat((Int(imageSize)*index)),0)
        
    }
    
    func layoutDataView(){
        
        
        // 卡路里视图容器
        var calorieView = UIView()
      //imageOffsetX, 400, 200, 200
        //calorieView.frame = CGRectMake()

        
        var calorieImg = UIImage(named: "calorie")

        
        // 卡路里图标
        var calorieImageView = UIImageView(image: calorieImg)
       // calorieImageView.frame = CGRectMake(25, 0, 20, 25)
        calorieView.addSubview(calorieImageView)
        
        // 卡路里计数标签
        var calorieValue = UILabel()
        calorieValue.text = "100 cal"
        calorieValue.textColor = UIColor.lightGrayColor()
        calorieView.addSubview(calorieValue)
        
        
        self.view.addSubview(calorieView)
        
        calorieView.snp_makeConstraints{(make) -> Void in
            make.width.height.equalTo(70);
            
            make.left.equalTo(self.view.snp_left).offset(30)
            make.bottom.equalTo(self.view.snp_bottom).offset(-80)
            //make.center.equalTo(self.view);
        }

        
        calorieImageView.snp_makeConstraints { (make) -> Void in
             make.width.height.equalTo(30)
            make.centerXWithinMargins.equalTo(calorieView.snp_centerX)
//            make.left.equalTo(calorieView.snp_left).offset(20)
           make.top.equalTo(calorieView.snp_top).offset(10)
           
        }
        
        calorieValue.textAlignment = NSTextAlignment.Center;
        calorieValue.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerXWithinMargins.equalTo(calorieView.snp_centerX)
            make.bottom.equalTo(calorieImageView.snp_bottom).offset(30)

        }
        
        // 计时器视图容器
        var timeView = UIView()
        //timeView.frame = CGRectMake(200, 400, 200, 200)
        
        var timeImg = UIImage(named: "time_clock")
        var timeImageView = UIImageView(image: timeImg)
        timeImageView.frame = CGRectMake(25, 0, 25, 25)
        timeView.addSubview(timeImageView)
        
        var timeValue = UILabel()
        timeValue.text = "00:00:00"
        timeValue.textColor = UIColor.lightGrayColor()
        timeValue.frame = CGRectMake(0, 25, 200, 25)
        timeView.addSubview(timeValue)
        
        self.view.addSubview(timeView)

        timeView.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(70);
            make.right.equalTo(self.view.snp_right).offset(-30);
            make.bottom.equalTo(self.view.snp_bottom).offset(-80)
        }
        
        timeImageView.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(30);
            make.centerXWithinMargins.equalTo(timeView.snp_centerX);
            make.top.equalTo(timeView.snp_top).offset(10)
        }
        
        timeValue.textAlignment = NSTextAlignment.Center;
        timeValue.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(100);
            make.height.equalTo(30);
            make.centerXWithinMargins.equalTo(timeView.snp_centerX);
            make.bottom.equalTo(timeImageView.snp_bottom).offset(30);
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CtrlViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        var offX:CGFloat = scrollView.contentOffset.x
        
        var index:Int = (Int)(offX / imageSize)
        
        pageCtrl.currentPage = index
    }
}
