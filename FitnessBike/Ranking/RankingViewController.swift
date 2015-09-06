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
        
        
      
        loadData()
   
        
        
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
       
        
        
        var cell:RankingTableViewCell? = tableView.dequeueReusableCellWithIdentifier("cellForCell") as? RankingTableViewCell

        if(cell == nil){
            cell = RankingTableViewCell(style:UITableViewCellStyle.Default,reuseIdentifier:"cellForCell")

        }
        var model = memberList.objectAtIndex(indexPath.row) as! RankingModel
        
        cell!.fillCell(model)
//
    


     
        
        
            

  
        
        
        return cell!
    }
}
