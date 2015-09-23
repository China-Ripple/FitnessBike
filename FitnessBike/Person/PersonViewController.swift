//
//  PersonViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/20.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
class PersonViewController: UIViewController,PNChartDelegate,BTSyncCallBack{
    var burnValueLabel:UILabel!
    var profileImgView:UIImageView!
    var dataView:UIView!
    var barChart:PNBarChart!
    var ChartLabel:UILabel!
    var segmentedCtrl:UISegmentedControl!
    var loading = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        createViews()
        showImage()
        showDataView()
        showChart()
        showSegment()
        
        // SyncProcessor.shared.registerCallBace(self)
        
        // Do any additional setup after loading the view.
    }
    
    func getCurrData(data: Double,duration:Int64) {
        dispatch_async(dispatch_get_main_queue(), {
            self.burnValueLabel.text = "\(SyncProcessor.shared.fetch()) cal"
        })
        
    }
    
    func showImage(){
        
        
        var proImage = UIImage(named: "profile")
        profileImgView.image = proImage
        profileImgView.clipsToBounds = true
       
        profileImgView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.centerXWithinMargins.equalTo(self.view)
            make.top.equalTo(self.view).offset(74)
            profileImgView.layer.cornerRadius = 40
            profileImgView.clipsToBounds = true
        }
        
        
        
        
        
        //        }
        
        
        
    }
    
    func showDataView(){
        
        
        
        
        
        //frame: CGRectMake(0, 200, UIScreen.mainScreen().bounds.size.width, 100)
        
        
        dataView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        
        
        
        
        dataView.snp_makeConstraints{ (make) -> Void in
            
            
            make.top.equalTo(self.profileImgView.snp_bottom).offset(10)
            make.width.equalTo(self.view.frame.size.width)
            make.height.equalTo(60)
            
        }
        //        var burnLabel = UILabel(frame: CGRectMake(20, 10, 80, 30))
        var burnLabel = UILabel()
        burnLabel.text = "今日燃烧总量"
        burnLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(burnLabel)
        burnLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(dataView.snp_top).offset(10)
            make.left.equalTo(dataView.snp_left).offset(30)
            
        }
        //      var burnValueLabel = UILabel(frame: CGRectMake(30, 50, 80, 30))
        burnValueLabel = UILabel()
        burnValueLabel.text = "\(SyncProcessor.shared.fetch()) cal"
        burnValueLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(burnValueLabel)
        burnValueLabel.snp_makeConstraints { (make) -> Void in
            make.centerXWithinMargins.equalTo(burnLabel)
            make.top.equalTo(burnLabel.snp_bottom).offset(10)
        }
        //        var totalBurnLabel = UILabel(frame: CGRectMake(130, 10, 80, 30))
        var totalBurnLabel = UILabel()
        totalBurnLabel.text = "累计燃烧总量"
        totalBurnLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(totalBurnLabel)
        totalBurnLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(dataView).offset(10)
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
                make.top.equalTo(burnLabel.snp_bottom).offset(10)
            })
        }
        //        var maxBurnLabel = UILabel(frame: CGRectMake(240, 10, 80, 30))
        var maxBurnLabel = UILabel()
        maxBurnLabel.text = "最高燃烧纪录"
        maxBurnLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(maxBurnLabel)
        maxBurnLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(dataView.snp_top).offset(10)
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
            make.top.equalTo(maxBurnLabel.snp_bottom).offset(10)
            
        }
        
        
        
        
        
        
    }
    
    func showChart(){
        
        
        
        ChartLabel.textColor = PNGreenColor
        ChartLabel.font = UIFont(name: "Avenir-Medium", size:12.0)
        ChartLabel.textAlignment = NSTextAlignment.Center
        ChartLabel.text = "过去七天燃烧卡路里的记录"
        ChartLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.greaterThanOrEqualTo(self.dataView.snp_bottom).offset(0)
            make.bottom.lessThanOrEqualTo(self.barChart.snp_top).offset(-10)
            make.centerXWithinMargins.equalTo(self.view.snp_centerX)
        }
        

        
        
        
        
        
        
        // var barChart = PNBarChart()
        barChart.backgroundColor = UIColor.clearColor()
        barChart.animationType = .Waterfall
        barChart.labelMarginTop = 5.0
        barChart.yLabelSum = 5
        
        barChart.strokeColor = UIColor(hexString: "#3ED8EE")!
        //        barChart.yLabelFormatter = ({(yValue: CGFloat) -> NSString in
        //            var yValueParsed:CGFloat = yValue
        //            var labelText:NSString = NSString(format:"%1.f",yValueParsed)
        //            println("labelText:\(labelText) ,yValue:\(yValue)")
        //            return labelText;
        //        })
        barChart.xLabels = ["150","24","120","240","100","10","88"]
        //barChart.yLabels = ["30","60","90","120","150"]
        barChart.yValues = [150,24,120,240,100,10,88]
        barChart.strokeChart()
        barChart.delegate = self
       
        barChart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        barChart.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(ChartLabel.snp_bottom).offset(10)
            make.bottom.greaterThanOrEqualTo(segmentedCtrl.snp_top).offset(0)
            make.centerXWithinMargins.equalTo(self.view)
            make.width.equalTo(320)
            make.height.equalTo(200)
        }
        
        
    }
    
    func createViews(){
        profileImgView = UIImageView()
         self.view.addSubview(profileImgView)
        
        
        ChartLabel = UILabel()
         self.view.addSubview(ChartLabel)
        
        self.segmentedCtrl = UISegmentedControl()
        self.view.addSubview(segmentedCtrl)
        
        dataView = UIView()
        self.view.addSubview(dataView)
        
        barChart = PNBarChart(frame: CGRectMake(0, 285.0, 320.0, 150.0))
        self.view.addSubview(barChart)
    }
    func showSegment(){
        
        
        
        segmentedCtrl.insertSegmentWithTitle("里程", atIndex: 0, animated: false)
        segmentedCtrl.insertSegmentWithTitle("卡路里", atIndex: 1, animated: false)
        
        segmentedCtrl.selectedSegmentIndex = 0;
       
        segmentedCtrl.snp_makeConstraints { (make) -> Void in

            make.centerXWithinMargins.equalTo(self.view)
            make.bottom.equalTo(self.view.snp_bottom).offset(-60)
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
        
       // loadCalorie()
    }
    
    
}

extension PersonViewController{
    
    func loadCalorie(){
        if self.loading {
            return
        }
        self.loading = true
        
        Alamofire.request(Router.WeeklyCalories()).responseJSON{
            (_,_,json,error) in
            self.loading = false
            
            //            if error != nil {
            //                var alert = UIAlertView(title: "网络异常", message: "请检查网络设置", delegate: nil, cancelButtonTitle: "确定")
            //                alert.show()
            //                return
            //            }
            dispatch_async(dispatch_get_main_queue(), {
                self.barChart.xLabels = ["3400","34340","23340","9952111","90034","23434","14343"]
                self.barChart.strokeChart()
            })
            
        }
    }
    
    func loadDistance(){
        
    }
    
}
