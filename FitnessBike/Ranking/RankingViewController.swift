//
//  RankingViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/14.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import Alamofire

class RankingViewController: UIViewController {
    
    
   
    @IBOutlet weak var tableView: UITableView!
    
  

    var tests:NSMutableArray!
    var prevButton:UIBarButtonItem!
    var accessory:UITableViewCellAccessoryType!
    var background:UIImageView! //used for transparency test
    var allowMultipleSwipe:Bool!
    
    
    var segmentedCtrl:UISegmentedControl!
    var  msgItem:UIButton!
    var memberList:NSMutableArray! = NSMutableArray()
    var addItem:UIBarButtonItem!
    var newMsg:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
        

        for i in 0...100 {
            var model = RankingModel()
            model.position = Int64(i+1)
            model.name = "宁泽涛 \(i)"
            memberList.addObject(model)
            
        }
        
        tableView.dataSource = self
        tableView.delegate = self

        
        
        
        // Do any additional setup after loading the view.
        
        
      
      //  loadData()
   
        tests = TestData.data()
        
        
    }
    
    func loadData(){
        
        Alamofire.request(Router.AllRanking(maxId: 10,count: 1)).responseJSON{
            (_,_,json,error) in
        
            
            if error != nil {
                
                var alert = UIAlertView(title: "网络异常", message: "请检查网络设置", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                return
            }
            
            
            var result = JSON(json!)
            
            println("result: \(result)")
            
        }
    }
    
    func layoutNavigationBar(){
        
        let shareItem=UIBarButtonItem(image: UIImage(named: "share"), style: UIBarButtonItemStyle.Bordered, target: self, action: "share:")
        //  添加到到导航栏上
        self.navigationItem.leftBarButtonItem = shareItem;
        
        
        addItem=UIBarButtonItem(image: UIImage(named: "add"), style: UIBarButtonItemStyle.Bordered, target: self, action: "addFriends:")
        //  添加到到导航栏上
        self.navigationItem.rightBarButtonItem = addItem;
        
        
        
        
        
        msgItem=UIButton(frame: CGMakeRect(270, 10, 30, 30))
        msgItem.setBackgroundImage(UIImage(named: "message"), forState: UIControlState.Normal)
        msgItem.addTarget(self, action: "checkMessage:", forControlEvents: UIControlEvents.TouchUpInside)
        //  添加到到导航栏上
         self.navigationController!.navigationBar.addSubview(msgItem)
        
         newMsg=UIImageView(frame: CGMakeRect(270, 10, 15, 15))
        newMsg.image = UIImage(named: "newmsg")
        //  添加到到导航栏上
        self.navigationController!.navigationBar.addSubview(newMsg)
        
        
        
        
        segmentedCtrl = UISegmentedControl()
        segmentedCtrl.frame = CGRectMake(100, 5, 100, 30)
        
        segmentedCtrl.insertSegmentWithTitle("排行榜", atIndex: 0, animated: false)
        segmentedCtrl.insertSegmentWithTitle("PK榜", atIndex: 1, animated: false)
       
        segmentedCtrl.selectedSegmentIndex = 0;
        self.navigationController!.navigationBar.addSubview(segmentedCtrl)
        
        
    
    }
    
    override func viewDidAppear(animated: Bool) {
         layoutNavigationBar()
        
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        cleanNavigationBar()
        
        super.viewDidDisappear(animated)
    }
    
    func cleanNavigationBar(){
        segmentedCtrl.removeFromSuperview()
        msgItem.removeFromSuperview()
        newMsg.removeFromSuperview()
    }
    
    func checkMessage(sender:AnyObject?){
        
        var msgVC = MessageListViewController();
        
        self.navigationController!.pushViewController(msgVC, animated:true)
        
    }
    
    func share(sender:AnyObject?){
        
    }
    
    func addFriends(sender:AnyObject?){
        
        var friendRecommenderVC = FriendRecommenderViewController();
        
        self.navigationController!.pushViewController(friendRecommenderVC, animated:true)
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

extension RankingViewController:UITableViewDataSource,UITableViewDelegate{
//    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String!
    {
        return "  PK  "
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    
    {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
//            memberList.removeObjectAtIndex(indexPath.row)
//            // Delete the row from the data source.
            
            
//            tableView.deleteRowsAtIndexPaths([indexPath],withRowAnimation:UITableViewRowAnimation.Fade)
            
            var competitionVC = CompetitionViewController();
            
            self.navigationController!.pushViewController(competitionVC, animated:true)
            
        }
        else if (editingStyle == UITableViewCellEditingStyle.Insert) {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return  true
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return 100
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return memberList.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
       
        
//        
//        var cell:RankingTableViewCell? = tableView.dequeueReusableCellWithIdentifier("cellForCell") as? RankingTableViewCell
//
//        if(cell == nil){
//            cell = RankingTableViewCell(style:UITableViewCellStyle.Default,reuseIdentifier:"cellForCell")
//
//        }
//        var model = memberList.objectAtIndex(indexPath.row) as! RankingModel
//        
//        cell!.fillCell(model)
////
        
        
        var cell:RankingTableViewCell?
        
        let reuseIdentifier:String = "programmaticCell";
        cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? RankingTableViewCell;
        if (cell == nil) {
            cell = RankingTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        }
        
//        cell!.accessoryType = accessory;
       // cell!.delegate = self;
      //  cell!.allowsMultipleSwipe = false;
        var model = memberList.objectAtIndex(indexPath.row) as! RankingModel
        cell!.fillCell(model)
        
        return cell!
    }
    
    
}
//
extension RankingViewController:MGSwipeTableCellDelegate{
    
//#if TEST_USE_MG_DELEGATE
    
    func swipeTableCell(cell: MGSwipeTableCell!, canSwipe direction: MGSwipeDirection) -> Bool {
        return true
    }
    
//    
    func swipeTableCell(cell: MGSwipeTableCell!, swipeButtonsForDirection direction: MGSwipeDirection, swipeSettings: MGSwipeSettings!, expansionSettings: MGSwipeExpansionSettings!) -> [AnyObject]!
    {
        var data:TestData = tests.objectAtIndex(tableView.indexPathForCell(cell)!.row) as! TestData;
        swipeSettings.transition = MGSwipeTransition.Border;
        swipeSettings.onlySwipeButtons = false
        swipeSettings.keepButtonsSwiped = true
          expansionSettings.buttonIndex = 0
         expansionSettings.fillOnTrigger = false;
        if (direction == MGSwipeDirection.LeftToRight) {
            return createLeftButtons(Int(data.leftButtonsCount)) as [AnyObject];
        }
        else {
            return createRightButtons(Int(data.rightButtonsCount)) as [AnyObject];
        }
    }
    
    
   
    
    

    
    func createLeftButtons(number:Int)->[AnyObject]
   {
        var result:[AnyObject] = [AnyObject]();
        var colors:[UIColor] = [UIColor.grayColor(),
            UIColor(red: 0, green: 0x99/255.0, blue: 0xcc/255.0, alpha: 1.0),
            UIColor(red: 0.59, green:0.29, blue:0.08, alpha: 1.0)]

 
        var icons = [ UIImage(named: "check"), UIImage(named:"fav"),UIImage(named:"menu")]
    
    
        for  i in 0...number-1
        {
            
           var button:MGSwipeButton = MGSwipeButton(title: "", icon: icons[i], backgroundColor: colors[i]);
            
            result.append(button)

        }
        return result;
    }
    
    
    func createRightButtons( number:Int)->[AnyObject]
    {
          var result:[AnyObject] = [AnyObject]();
            var titles:[String] = ["Delete", "more"];
            var colors:[UIColor] = [UIColor.redColor(),UIColor.lightGrayColor()];
          for  i in 0...number-1
        {
            var button:MGSwipeButton = MGSwipeButton(title: titles[i] as String, backgroundColor: colors[i], padding: 0)

//            NSLog(@"Convenience callback received (right).");
//            BOOL autoHide = i != 0;
//            return autoHide; //Don't autohide in delete button to improve delete expansion animation
//            }];
            result.append(button)
        }
        return result;
    }

// #endif
}
