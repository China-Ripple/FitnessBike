//
//  UITabBarControllerViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/15.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

let tabbarHeight:CGFloat = 50.0
let tabbarItemWidth:Int = 80

class UITabBarControllerViewController: UITabBarController {
    

    var myTabbar :UIView?
    var slider :UIView?
    let btnBGColor:UIColor =  UIColor(red:125/255.0, green:236/255.0,blue:198/255.0,alpha: 1)
    let tabBarBGColor:UIColor =  UIColor.lightGrayColor()
    //UIColor(red:251/255.0, green:173/255.0,blue:69/255.0,alpha: 1)
    let titleColor:UIColor =  UIColor(red:52/255.0, green:156/255.0,blue:150/255.0,alpha: 1)
    
    
    let itemArray = ["控制","个人","竞赛","活动"]
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        self.title = "最新"
    }
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initViewControllers()
        // Do any additional setup after loading the view.
    }
    func setupViews()
    {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()
        self.tabBar.hidden = true
        var width = self.view.frame.size.width
        var height = self.view.frame.size.height
        self.myTabbar = UIView(frame: CGRectMake(0,height-tabbarHeight,width,tabbarHeight))
        self.myTabbar!.backgroundColor = tabBarBGColor
        self.slider = UIView(frame:CGRectMake(0,0,CGFloat(tabbarItemWidth),tabbarHeight))
        self.slider!.backgroundColor = UIColor.whiteColor()//btnBGColor
        self.myTabbar!.addSubview(self.slider!)
        
        self.view.addSubview(self.myTabbar!)
        
        var count = self.itemArray.count
        
        for var index = 0; index < count; index++
        {
            var btnWidth = (CGFloat)(index*tabbarItemWidth)
            var button  = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
            button.frame = CGRectMake(btnWidth, 0,CGFloat(tabbarItemWidth),tabbarHeight)
            button.tag = index+100
            var title = self.itemArray[index]
            button.setTitle(title, forState: UIControlState.Normal)

          
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.setTitleColor(tabBarBGColor, forState: UIControlState.Selected)
            
            button.addTarget(self, action: "tabBarButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            self.myTabbar?.addSubview(button)
            if index == 0
            {
                button.selected = true
            }
        }
    }
    func initViewControllers()
    {
        var vc1 = CtrlViewController()
        var vc2 = PersonViewController()
        var vc3 = RankingViewController()
        var vc4 = ActivityViewController()
        self.viewControllers = [vc1,vc2,vc3,vc4]
    }
    
    
    func tabBarButtonClicked(sender:UIButton)
    {
        var index = sender.tag
        
        for var i = 0;i<4;i++
        {
            var button = self.view.viewWithTag(i+100) as! UIButton
            if button.tag == index
            {
                button.selected = true
            }
            else
            {
                button.selected = false
            }
        }
        
        UIView.animateWithDuration( 0.3,
            animations:{
                
                self.slider!.frame = CGRectMake(CGFloat((index-100)*tabbarItemWidth),0,CGFloat(tabbarItemWidth),tabbarHeight)
                
        })
        self.title = itemArray[index-100] as String
        self.selectedIndex = index-100
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
