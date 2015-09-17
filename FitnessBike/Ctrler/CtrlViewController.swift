//
//  CtrlViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/14.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit


class CtrlViewController: UIViewController {
    
    let imageSize:CGFloat = 200
    let imageOffsetX:CGFloat = 60
    let imageOffsetY:CGFloat = 100
    var scrollView:UIScrollView!
    var pageCtrl:UIPageControl!
    var shareButton:UIButton!
    var calorieValue:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //  var bleService = MyBleService.getInstance()
        
        //        shareButton = UIButton(frame: CGRectMake(15, 30, 18, 18))
        var shareButton = UIButton()
        shareButton.setImage(UIImage(named: "share"), forState: UIControlState.Normal)
        self.view.addSubview(shareButton)
        shareButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp_top).offset(22)
            make.left.equalTo(self.view.snp_left).offset(9.5)
            make.width.equalTo(20)
            make.height.equalTo(20)
            
        }
        
        
        
        layoutScrollPage()
        layoutDataView()
        
        testNSThread()
        var ble =  MyBleService.getInstance(BlueToothBiz())
        
    }
    
    func layoutScrollPage(){
        scrollView = UIScrollView(frame:CGRectMake(imageOffsetX,imageOffsetY,imageSize,imageSize))
        scrollView = UIScrollView()
        //scrollView.backgroundColor = UIColor.grayColor()
        scrollView.pagingEnabled=true
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.showsVerticalScrollIndicator=false
        scrollView.delegate = self
        
        var bikeImage = UIImage(named: "bike_image")
        //var bikeScaledImage = ImageUtil.scaleImage(bikeImage!,scaleSize:imageSize)
        
        var bikeImageView = UIImageView(image:bikeImage)
        bikeImageView.frame = CGRectMake(0, 0, imageSize, imageSize)
        self.view.addSubview(scrollView)
        scrollView.addSubview(bikeImageView)
        scrollView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.centerXWithinMargins.equalTo(self.view)
            make.top.equalTo(self.view).offset(80)
        }
        
        
        
        
        
        
        
        var dataImage = UIImage(named: "data_image")
        var dataImageView = UIImageView(image:dataImage)
        dataImageView.frame = CGRectMake(imageSize, 0, imageSize, imageSize)
        scrollView.addSubview(dataImageView)
        
        
        scrollView.contentSize = CGSizeMake(imageSize*2, imageSize)
        scrollView.indicatorStyle = UIScrollViewIndicatorStyle.White
        
        
        
        
        
        
        
        
        self.view.addSubview(scrollView)
        self.view.backgroundColor = UIColor.darkGrayColor()
        
        
        
        pageCtrl = UIPageControl(frame:CGRectMake(imageOffsetX, imageOffsetY+imageSize+10, imageSize, 60))
        
        
        pageCtrl.numberOfPages = 2
        pageCtrl.currentPage = 0
        pageCtrl.addTarget(self, action: "pageTurn:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(pageCtrl)
        
        pageCtrl.snp_updateConstraints { (make) -> Void in
            make.centerWithinMargins.equalTo(self.view)
            make.top.equalTo(self.view.snp_top).offset(320)
        }
        
        
        
        
    }
    
    func pageTurn(sender:AnyObject?){
        var pageCtrl = sender as! UIPageControl
        
        var index = pageCtrl.currentPage
        
        scrollView.contentOffset = CGPointMake(CGFloat((Int(imageSize)*index)),0)
        
    }
    
    func layoutDataView(){
        
        var calorieView = UIView()
        //        calorieView.frame = CGRectMake(imageOffsetX, 400, 200, 200)
        
        var calorieImg = UIImage(named: "calorie")
        var calorieImageView = UIImageView(image: calorieImg)
        self.view.addSubview(calorieView)
        //        calorieImageView.frame = CGRectMake(25, 0, 20, 25)
        calorieView.addSubview(calorieImageView)
        calorieView.snp_makeConstraints { (make) -> Void in
            //
            make.left.equalTo(self.view.snp_left).offset(60)
            make.bottom.equalTo(self.view.snp_bottom).offset(-150)
            
            //
            
            
            
        }
        
        
        
        
        
        calorieValue = UILabel()
        calorieValue.text = "100 cal"
        calorieValue.textColor = UIColor.lightGrayColor()
        //        calorieValue.frame = CGRectMake(0, 25, 200, 25)
        calorieView.addSubview(calorieValue)
        
        self.view.addSubview(calorieView)
        calorieValue.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(self.view.snp_left).offset(50)
            make.bottom.equalTo(self.view.snp_bottom).offset(-70)
            
        }
        
        
        
        var timeView = UIView()
        //        timeView.frame = CGRectMake(200, 400, 200, 200)
        
        var timeImg = UIImage(named: "time_clock")
        var timeImageView = UIImageView(image: timeImg)
        //        timeImageView.frame = CGRectMake(25, 0, 25, 25)
        timeView.addSubview(timeImageView)
        self.view.addSubview(timeView)
        timeView.snp_remakeConstraints { (make) -> Void in
            make.right.equalTo(self.view.snp_right).offset(-110)
            make.bottom.equalTo(self.view.snp_bottom).offset(-150)
            
        }
        
        
        
        var timeValue = UILabel()
        timeValue.text = "00:00:00"
        timeValue.textColor = UIColor.lightGrayColor()
        //        timeValue.frame = CGRectMake(0, 25, 200, 25)
        timeView.addSubview(timeValue)
        
        
        
        
        self.view.addSubview(timeView)
        timeValue.snp_makeConstraints { (make) -> Void in
            
            make.right.equalTo(self.view.snp_right).offset(-50)
            make.bottom.equalTo(self.view.snp_bottom).offset(-70)
            
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

extension CtrlViewController{
    
    func testGCDThread()
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            //这里写需要大量时间的代码
            
            for var i = 0; i < 100000; i++
            {
                println("GCD thread running.")
            }
            
            sleep(5);
            
            dispatch_async(dispatch_get_main_queue(), {
                
                //这里返回主线程，写需要主线程执行的代码
                println("这里返回主线程，写需要主线程执行的代码")
            })
        })
    }
    func testNSThread()
    {
        //方式一
        //NSThread.detachNewThreadSelector("threadInMainMethod:",toTarget:self,withObject:nil)
        
        //方式二
        var myThread = NSThread(target:self,selector:"threadInMainMethod:",object:nil)
        myThread.start()
        
    }
    
    func threadInMainMethod(sender : AnyObject)
    {
        var state:Bool = true
        var time = 0
        while(state){
            
            time++;
            
            if(time == 100){
                state = false
            }
            //F0 10 15 35 00 10 F1
            //工作模式
                        var buffer :UnsafeMutablePointer<UInt8> = UnsafeMutablePointer.alloc(10)
                        buffer.initialize(1)
                        buffer[0] = 0xF0
                        buffer[1] = 0x10
                        buffer[2] = 0x15
                        buffer[3] = 0x35
                        buffer[4] = 0x00
                        buffer[5] = 0x10
                        buffer[6] = 0xF1
            
            //同步模式
            //F0 10 20 23 0E 09 11 07 15 35 01 F1
//            var buffer :UnsafeMutablePointer<UInt8> = UnsafeMutablePointer.alloc(15)
//            buffer.initialize(1)
//            buffer[0] = 0xF0
//            buffer[1] = 0x10
//            buffer[2] = 0x20
//            buffer[3] = 0x23
//            buffer[4] = 0x0E
//            buffer[5] = 0x09
//            buffer[6] = 0x11
//            buffer[7] = 0x07
//            buffer[8] = 0x15
//            buffer[9] = 0x35
//            buffer[10] = 0x01
//            buffer[11] = 0xF1
            
            BlueToothBiz().reslove(buffer)
            
            buffer.destroy()
            buffer.dealloc(1)
            
            buffer = nil
            dispatch_async(dispatch_get_main_queue(), {
                self.calorieValue.text = "\(time) cal"
            })
            sleep(1);
            println("NSThread running....")
        }
        println("NSThread over.")
    }
    
}
