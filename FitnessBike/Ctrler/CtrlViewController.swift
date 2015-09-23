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
    var calorieValue:UILabel!
    var timeValue:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        layoutScrollPage()
        layoutDataView()
        self.view.backgroundColor = UIColor(hexString: "#21262c")

        var ble =  MyBleService.getInstance(BlueToothBiz())
        
        
        
    }
    
    
       
    func layoutScrollPage(){
        
        //
        scrollView = UIScrollView(frame:CGRectMake(0,0,imageSize,imageSize))
        scrollView.pagingEnabled=true
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.showsVerticalScrollIndicator=false
        scrollView.contentSize =  CGSize(width: imageSize*2,  height:imageSize)
        scrollView.indicatorStyle = UIScrollViewIndicatorStyle.White
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.redColor()
        self.view.addSubview(scrollView)
        
        scrollView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(imageSize)
            make.height.equalTo(imageSize)
            make.centerXWithinMargins.equalTo(self.view)
            make.top.equalTo(self.view).offset(65)
        }
        
//        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        scrollView.contentOffset = CGPointMake(0, 0);
        
        var bikeImage:UIImage! = UIImage(named: "bike_image")
        var bikeScaledImage =  ImageUtil.scaleImage( CGSize(width: imageSize,  height: imageSize), img:bikeImage)
        var bikeImageView = UIImageView(frame: CGRectMake(0, 0, imageSize, imageSize))
        bikeImageView.image = bikeScaledImage
        
        scrollView.addSubview(bikeImageView)
        


        
//        println("scrollView.frame.size.width \(scrollView.frame.size.width)")
//
       
       
        
//        
//        
//        
//        
        var dataImage = UIImage(named: "data_image")
        var dataScaledImage =  ImageUtil.scaleImage( CGSize(width: imageSize,  height: imageSize), img:dataImage!)
        var dataImageView = UIImageView(image:dataScaledImage)
        dataImageView.frame = CGRectMake(imageSize, 0, imageSize, imageSize)
        scrollView.addSubview(dataImageView)

        
//
        pageCtrl = UIPageControl(frame:CGRectMake(imageOffsetX, imageOffsetY+imageSize+10, imageSize, 60))
        pageCtrl.numberOfPages = 2
        pageCtrl.currentPage = 0
        pageCtrl.addTarget(self, action: "pageTurn:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(pageCtrl)
        
        pageCtrl.snp_updateConstraints { (make) -> Void in
            make.centerXWithinMargins.equalTo(scrollView)
            make.top.equalTo(scrollView.snp_bottom).offset(20)
        }
//
//        
        scrollView.contentOffset = CGPointMake(0,0)
        
    }
    
    func pageTurn(sender:AnyObject?){
        var pageCtrl = sender as! UIPageControl
        
        var index = pageCtrl.currentPage
        
        scrollView.contentOffset = CGPointMake(CGFloat((Int(imageSize)*index)),0)
        
    }
    
    func layoutDataView(){
        
        var calorieView = UIView()
        self.view.addSubview(calorieView)
        
        calorieView.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view.snp_bottom).offset(-100)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        
        var calorieImageView = UIImageView()
        calorieImageView.image = UIImage(named: "calorie")
        calorieView.addSubview(calorieImageView)
        calorieImageView.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(calorieView.snp_top).offset(10)
            make.left.equalTo(calorieView.snp_left).offset(40)
        }
//
//        
        calorieValue = UILabel()
        calorieValue.text = "100 cal"
        calorieValue.textColor = UIColor.lightGrayColor()
        calorieView.addSubview(calorieValue)

        
        
        calorieValue.snp_makeConstraints { (make) -> Void in
            
            make.centerXWithinMargins.equalTo(calorieImageView)
            make.top.equalTo(calorieImageView.snp_bottom).offset(20)
            
        }

        
        var timeView = UIView()
        self.view.addSubview(timeView)
        
        timeView.snp_remakeConstraints { (make) -> Void in
            make.right.equalTo(self.view.snp_right)
            make.bottom.equalTo(self.view.snp_bottom).offset(-100)
            make.height.equalTo(100)
            make.width.equalTo(200)
        }
        
        var timeImg = UIImage(named: "time_clock")
        var timeImageView = UIImageView(image: timeImg)
        timeView.addSubview(timeImageView)
        timeImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(timeView.snp_top).offset(10)
            make.right.equalTo(timeView.snp_right).offset(-40)

        }
        
 
        timeValue = UILabel()
        timeValue.text = "00:00:00"
        timeValue.textColor = UIColor.lightGrayColor()
        timeView.addSubview(timeValue)
        
        timeValue.snp_makeConstraints { (make) -> Void in
            make.centerXWithinMargins.equalTo(timeImageView)
            make.top.equalTo(timeImageView.snp_bottom).offset(20)
        }

    }
    
    func createViews(){
        
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

extension CtrlViewController:BTSyncCallBack{
    
    
    
    func getCurrData(distance:Double,duration:Int64) {
        
        dispatch_async(dispatch_get_main_queue(), {
            self.calorieValue.text = "\(distance) cal"
            self.timeValue.text = "\(duration)"
        })
    }
    
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
            
            if(time == 36){
                state = false
            }
            //F0 10 15 78 00 10 F1
            //工作模式
                        var buffer :UnsafeMutablePointer<UInt8> = UnsafeMutablePointer.alloc(10)
                        buffer.initialize(1)
                        buffer[0] = 0xF0
                        buffer[1] = 0x10
                        buffer[2] = 0x15
                        buffer[3] = 0x78
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
            SyncProcessor.shared.registerCallBace(self)
            
            buffer.destroy()
            buffer.dealloc(1)
            
            buffer = nil
           
            sleep(1);
           
        }
        println("NSThread over.")
    }
    
}
