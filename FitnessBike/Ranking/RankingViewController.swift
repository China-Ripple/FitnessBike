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
    
    
   
    var tableView: UITableView!
    

    var loading:Bool = false
    
    var segmentedCtrl:UISegmentedControl!
    var  msgItem:UIButton!
    var memberList:[AnyObject] = [AnyObject]()
    var addItem:UIBarButtonItem!
    var newMsg:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        
        var paddingTop = self.navigationController!.navigationBar.frame.height + Utility.getStatusHeight()
        

        tableView = UITableView(frame: CGRectMake(0, paddingTop, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Plain)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)

        
        self.tableView.addHeaderWithCallback{
            
            self.loadData(0, isPullRefresh: true)
        }
        
        self.tableView.addFooterWithCallback{
           if(self.memberList.count>0) {
                var  maxId = (self.memberList.last!.valueForKey("id") as! String).toInt()


                self.loadData(maxId!, isPullRefresh: false)
           }
        }
        
        self.tableView.headerBeginRefreshing()

        
        // Do any additional setup after loading the view.
        
        
      
      //  loadData()
   
     
        
        
    }
    
    override func  viewWillAppear(animated: Bool) {
        self.navigationController!.title = ""
        super.viewWillAppear(animated)
    }
    
    func productModels(){
        

    }
    
    func loadData(maxId:Int,isPullRefresh:Bool){
        if self.loading {
            return
        }
        self.loading = true
        
        Alamofire.request(Router.AllRanking(maxId: maxId, num: 10)).responseJSON{
            (_,_,json,error) in
            
            self.loading = false
            
            if(isPullRefresh){
                self.tableView.headerEndRefreshing()
            }
            else{
                self.tableView.footerEndRefreshing()
            }
            if error != nil {
                var alert = UIAlertView(title: "网络异常", message: "请检查网络设置", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                return
            }

            var result = JSON(json!)
            
            println("result: \(result)")
            
            if(result["response"].stringValue == "error") {
                
                Utility.showNetMsg(result)
                
            }
            else{
                
                var items = result["people"].object as! [AnyObject]
                
                if(items.count==0){
                    return
                }
                
                
                if(isPullRefresh){

                    self.memberList.removeAll(keepCapacity: false)
                }
                
                for  it in items {
                    
                    self.memberList.append(it)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
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
//    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String!
//    {
//        return "  PK  "
//    }
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
//    
//    {
//        if (editingStyle == UITableViewCellEditingStyle.Delete) {
////            memberList.removeObjectAtIndex(indexPath.row)
////            // Delete the row from the data source.
//            
//            
////            tableView.deleteRowsAtIndexPaths([indexPath],withRowAnimation:UITableViewRowAnimation.Fade)
//            
//            var competitionVC = CompetitionViewController();
//            
//            self.navigationController!.pushViewController(competitionVC, animated:true)
//            
//        }
//        else if (editingStyle == UITableViewCellEditingStyle.Insert) {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }
//    
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
//        return  true
//    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return 100
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return memberList.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
       
        
        
        var cell:RankingTableViewCell?
        
        let reuseIdentifier:String = "programmaticCell";
        cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? RankingTableViewCell;
        if (cell == nil) {
            cell = RankingTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        }
        
//        cell!.accessoryType = accessory;
        cell!.delegate = self;
      //  cell!.allowsMultipleSwipe = false;
        var obj = memberList[indexPath.row]
            
        var model = RankingModel()
        model.id = (obj.valueForKey("id") as! String).toInt()
        model.name = obj.valueForKey("name") as! String
        model.imageUrl = obj.valueForKey("imageUrl") as! String
        model.position = obj.valueForKey("position") as! Int
        model.kilometre =  obj.valueForKey("kilometre") as! Int
      
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
        swipeSettings.transition = MGSwipeTransition.Border;
        swipeSettings.onlySwipeButtons = false
        swipeSettings.keepButtonsSwiped = true
        
         expansionSettings.fillOnTrigger = false;
        if (direction == MGSwipeDirection.LeftToRight) {
            expansionSettings.buttonIndex = 1
            return createLeftButtons(1) as [AnyObject];
        }
        else {
            expansionSettings.buttonIndex = 1
            return createRightButtons(1) as [AnyObject];
        }
    }
    
    func pk(){
        var competitionVC = CompetitionViewController();
        self.navigationController!.pushViewController(competitionVC, animated:true)
    }
    
    func deleteFriend(indexPath:NSIndexPath){
         memberList.removeAtIndex(indexPath.row)
        //tableView.deleteRowsAtIndexPaths( withRowAnimation:UITableViewRowAnimationLeft];
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
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
            
            var button:MGSwipeButton = MGSwipeButton(title: " Delete ",backgroundColor: UIColor.redColor(), padding: 0, callback: { (sender) -> Bool in
                
                var indexPath:NSIndexPath = self.tableView.indexPathForCell(sender)!
                self.deleteFriend(indexPath)
                return true
                
            });
            
            
            
            
            result.append(button)

        }
        return result;
    }
    
    
    func createRightButtons( number:Int)->[AnyObject]
    {
          var result:[AnyObject] = [AnyObject]();
            var titles:[String] = ["PK", "more"];
            var colors:[UIColor] = [UIColor.redColor(),UIColor.lightGrayColor()];
          for  i in 0...number-1
        {
       
            
            var pkButtton:MGSwipeButton = MGSwipeButton(title: "   PK   ", backgroundColor: UIColor.greenColor(), padding: 10, callback: { (sender) -> Bool in
            
                self.pk()
                return true
                
            })
            
           
//            NSLog(@"Convenience callback received (right).");
//            BOOL autoHide = i != 0;
//            return autoHide; //Don't autohide in delete button to improve delete expansion animation
//            }];
            result.append(pkButtton)
        }
        return result;
    }

// #endif
}
