//
//  PersonViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/20.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController,PNChartDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        showChart()
        showSegment()
        showDataView()
        showImage()
        
        // Do any additional setup after loading the view.
    }
    
    func showImage(){
        
        var proImage = UIImage(named: "profile")
        
        var profileImgView = UIImageView(frame: CGRectMake(110, 70, 100, 100))
        profileImgView.image = proImage
        profileImgView.layer.cornerRadius = profileImgView.frame.size.width/2
        
        profileImgView.clipsToBounds = true
        
        
        
        
        self.view.addSubview(profileImgView)
    }
    
    func showDataView(){
        
        
        
        var dataView = UIView(frame: CGRectMake(0, 200, UIScreen.mainScreen().bounds.size.width, 100))
        
        
        var burnLabel = UILabel(frame: CGRectMake(20, 10, 80, 30))
        burnLabel.text = "今日燃烧总量"
        burnLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(burnLabel)
        
        var burnValueLabel = UILabel(frame: CGRectMake(30, 40, 80, 30))
        burnValueLabel.text = "128cal"
        burnValueLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(burnValueLabel)
        
        //=============================
        
        
        var totalBurnLabel = UILabel(frame: CGRectMake(130, 10, 80, 30))
        totalBurnLabel.text = "累计燃烧总量"
        totalBurnLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(totalBurnLabel)
        
        var totalBurnValueLabel = UILabel(frame: CGRectMake(140, 40, 80, 30))
        totalBurnValueLabel.text = "22234cal"
        totalBurnValueLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(totalBurnValueLabel)
        
        
        //==============================
        
        var maxBurnLabel = UILabel(frame: CGRectMake(240, 10, 80, 30))
        maxBurnLabel.text = "最高燃烧纪录"
        maxBurnLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(maxBurnLabel)
        
        var maxBurnValueLabel = UILabel(frame: CGRectMake(250, 40, 80, 30))
        maxBurnValueLabel.text = "1234cal"
        maxBurnValueLabel.font = UIFont.boldSystemFontOfSize(10)
        dataView.addSubview(maxBurnValueLabel)
        
        
        self.view.addSubview(dataView)
        
        
        
    }
    
    func showChart(){
        var ChartLabel:UILabel = UILabel(frame: CGRectMake(0, 90, 320.0, 30))
        
        ChartLabel.textColor = PNGreenColor
        ChartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
        ChartLabel.textAlignment = NSTextAlignment.Center

        //Add BarChart
        ChartLabel.text = "Bar Chart"
        
        var barChart = PNBarChart(frame: CGRectMake(0, 285.0, 320.0, 150.0))
        barChart.backgroundColor = UIColor.clearColor()
        //            barChart.yLabelFormatter = ({(yValue: CGFloat) -> NSString in
        //                var yValueParsed:CGFloat = yValue
        //                var labelText:NSString = NSString(format:"%1.f",yValueParsed)
        //                return labelText;
        //            })
        
        
        // remove for default animation (all bars animate at once)
        barChart.animationType = .Waterfall
        
        
        barChart.labelMarginTop = 5.0
        barChart.xLabels = ["SEP 1","SEP 2","SEP 3","SEP 4","SEP 5","SEP 6","SEP 7"]
        barChart.yValues = [1,24,12,18,30,10,21]
        barChart.strokeChart()
        
        barChart.delegate = self
        
        //self.view.addSubview(ChartLabel)
        self.view.addSubview(barChart)
        
       

    }
    func showSegment(){
        
        var segmentedCtrl = UISegmentedControl()
        segmentedCtrl.frame = CGRectMake(100, 450, 100, 30)
        
        segmentedCtrl.insertSegmentWithTitle("里程", atIndex: 0, animated: false)
        segmentedCtrl.insertSegmentWithTitle("卡路里", atIndex: 1, animated: false)
        
        segmentedCtrl.selectedSegmentIndex = 0;

        
        self.view.addSubview(segmentedCtrl)
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
