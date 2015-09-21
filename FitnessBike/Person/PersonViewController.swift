//
//  PersonViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/20.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import SnapKit
class PersonViewController: UIViewController,PNChartDelegate,BTSyncCallBack{
    var burnValueLabel:UILabel!
    var profileImgView:UIImageView!
    var dataView:UIView!
    var barChart:PNBarChart!
    var segmentedCtrl:UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        showImage()
        showDataView()
        showChart()
        showSegment()
        
        SyncProcessor.shared.registerCallBace(self)
        
        // Do any additional setup after loading the view.
    }
    
    func getCurrData(data: Int64,duration:Int64) {
       dispatch_async(dispatch_get_main_queue(), {
              self.burnValueLabel.text = "\(SyncProcessor.shared.fetch()) cal"
        })
      
    }
    
    func showImage(){
        
        profileImgView = UIImageView()
        var proImage = UIImage(named: "profile")
        profileImgView.image = proImage
        profileImgView.clipsToBounds = true
        self.view.addSubview(profileImgView)
        profileImgView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.centerXWithinMargins.equalTo(self.view)
            make.top.equalTo(self.view).offset(74)
        }
        
        
        
        
        
        //        }
        
        
        
    }
    
    func showDataView(){
        
        
        
        
        
        //frame: CGRectMake(0, 200, UIScreen.mainScreen().bounds.size.width, 100)
        dataView = UIView()
        
        dataView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
     
        self.view.addSubview(dataView)
        
        
        dataView.snp_makeConstraints{ (make) -> Void in
            
            
            make.top.equalTo(self.profileImgView.snp_bottom).offset(10)
            make.width.equalTo(self.view.frame.size.width)
            make.height.equalTo(80)
            
        }
        //        var burnLabel = UILabel(frame: CGRectMake(20, 10, 80, 30))
        var burnLabel = UILabel()
        burnLabel.text = "今日燃烧总量"
        burnLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(burnLabel)
        burnLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(dataView.snp_top).offset(20)
            make.left.equalTo(dataView.snp_left).offset(30)
            
        }
        //      var burnValueLabel = UILabel(frame: CGRectMake(30, 50, 80, 30))
         burnValueLabel = UILabel()
        burnValueLabel.text = "\(SyncProcessor.shared.fetch()) cal"
        burnValueLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(burnValueLabel)
        burnValueLabel.snp_makeConstraints { (make) -> Void in
            make.centerXWithinMargins.equalTo(burnLabel)
            make.top.equalTo(burnLabel.snp_bottom).offset(20)
        }
        //        var totalBurnLabel = UILabel(frame: CGRectMake(130, 10, 80, 30))
        var totalBurnLabel = UILabel()
        totalBurnLabel.text = "累计燃烧总量"
        totalBurnLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(totalBurnLabel)
        totalBurnLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(dataView).offset(20)
            make.centerXWithinMargins.equalTo(dataView)
        }
        
        //        var totalBurnValueLabel = UILabel(frame: CGRectMake(140, 40, 80, 30))
        var totalBurnValueLabel = UILabel()
        totalBurnValueLabel.text = "22234cal"
        totalBurnValueLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(totalBurnValueLabel)
        totalBurnValueLabel.snp_makeConstraints { (make) -> Void in
            totalBurnValueLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.centerXWithinMargins.equalTo(totalBurnLabel)
                make.top.equalTo(burnLabel.snp_bottom).offset(20)
            })
        }
        //        var maxBurnLabel = UILabel(frame: CGRectMake(240, 10, 80, 30))
        var maxBurnLabel = UILabel()
        maxBurnLabel.text = "最高燃烧纪录"
        maxBurnLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(maxBurnLabel)
        maxBurnLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(dataView.snp_top).offset(20)
            make.right.equalTo(dataView.snp_right).offset(-30)
        }
        //                var maxBurnValueLabel = UILabel(frame: CGRectMake(250, 40, 80, 30))
        var maxBurnValueLabel = UILabel()
        maxBurnValueLabel.text = "1234cal"
        maxBurnValueLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(maxBurnValueLabel)
        self.view.addSubview(dataView)
        maxBurnValueLabel.snp_makeConstraints { (make) -> Void in
            make.centerXWithinMargins.equalTo(maxBurnLabel)
            make.top.equalTo(maxBurnLabel.snp_bottom).offset(20)
            
        }
        
        
        
        
        
        
    }
    
    func showChart(){
        //        var ChartLabel:UILabel = UILabel(frame: CGRectMake(0, 90, 320.0, 30))
        //        var ChartLabel:UILabel = UILabel()
        //        ChartLabel.textColor = PNGreenColor
        //        ChartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
        //        ChartLabel.textAlignment = NSTextAlignment.Center
        //        ChartLabel.text = "Bar Chart"
        
        
        barChart = PNBarChart(frame: CGRectMake(0, 285.0, 320.0, 150.0))
        
        
        
        // var barChart = PNBarChart()
        barChart.backgroundColor = UIColor.clearColor()
        barChart.animationType = .Waterfall
        barChart.labelMarginTop = 5.0
        barChart.xLabels = ["SEP 1","SEP 2","SEP 3","SEP 4","SEP 5","SEP 6","SEP 7"]
        barChart.yValues = [1,24,12,18,30,10,21]
        barChart.strokeChart()
        barChart.delegate = self
        self.view.addSubview(barChart)
        barChart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        barChart.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.dataView.snp_bottom).offset(10)
            make.bottom.equalTo(self.view.frame.size.height).offset(-100)
            make.centerXWithinMargins.equalTo(self.view)
            make.width.equalTo(320)
            make.height.equalTo(200)
        }
        
        
    }
    func showSegment(){
        
        var segmentedCtrl = UISegmentedControl()
        //        segmentedCtrl.frame = CGRectMake(100, 450, 100, 30)
        self.segmentedCtrl = segmentedCtrl;
        segmentedCtrl.insertSegmentWithTitle("里程", atIndex: 0, animated: false)
        segmentedCtrl.insertSegmentWithTitle("卡路里", atIndex: 1, animated: false)
        
        segmentedCtrl.selectedSegmentIndex = 0;
        self.view.addSubview(segmentedCtrl)
        segmentedCtrl.snp_makeConstraints { (make) -> Void in
            
            
            make.top.equalTo(barChart.snp_bottom).offset(10)
            
            
            make.centerXWithinMargins.equalTo(self.view)
            
            make.width.equalTo(100)
            make.height.equalTo(20)
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
    func userClickedOnLineKeyPoint(point: CGPoint, lineIndex: Int, keyPointIndex: Int)
    {
        println("Click Key on line \(point.x), \(point.y) line index is \(lineIndex) and point index is \(keyPointIndex)")
    }
    
    func userClickedOnLinePoint(point: CGPoint, lineIndex: Int)
    {
        println("Click Key on line \(point.x), \(point.y) line index is \(lineIndex)")
    }
    
    func userClickedOnBarChartIndex(barIndex: Int)
    {
        println("Click  on bar \(barIndex)")
    }
    
    
}
