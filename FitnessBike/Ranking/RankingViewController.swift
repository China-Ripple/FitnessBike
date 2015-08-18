//
//  RankingViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/14.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {
    
    
   
    @IBOutlet weak var tableView: UITableView!
    
    var memberList:[RankingModel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        memberList = [RankingModel]()
        
        

        // Do any additional setup after loading the view.
        
        
      
        
        layoutNavigationBar()
        
        
    }
    
    func layoutNavigationBar(){
        
        let shareItem=UIBarButtonItem(image: UIImage(named: "share"), style: UIBarButtonItemStyle.Bordered, target: self, action: "share:")
        //  添加到到导航栏上
        self.navigationItem.leftBarButtonItem = shareItem;
        
        
        let addItem=UIBarButtonItem(image: UIImage(named: "add"), style: UIBarButtonItemStyle.Bordered, target: self, action: "addFriends:")
        //  添加到到导航栏上
        self.navigationItem.rightBarButtonItem = addItem;
        
        
        
        var segmentedCtrl = UISegmentedControl()
        segmentedCtrl.frame = CGRectMake(100, 5, 100, 30)
        
        segmentedCtrl.insertSegmentWithTitle("排行榜", atIndex: 0, animated: false)
        segmentedCtrl.insertSegmentWithTitle("PK榜", atIndex: 1, animated: false)
       
        segmentedCtrl.selectedSegmentIndex = 0;
        self.navigationController!.navigationBar.addSubview(segmentedCtrl)
        
        
    
    }
    
    func share(sender:AnyObject?){
        
    }
    
    func addFriends(sender:AnyObject?){
        
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

extension RankingViewController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 100
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
       
        
        
        let cell:UITableViewCell!
        
        if(indexPath.row == 0){
            cell = tableView.dequeueReusableCellWithIdentifier("cellForTips", forIndexPath: indexPath)
            as? UITableViewCell
            
            
            
        }
        else{
            cell = tableView.dequeueReusableCellWithIdentifier("cellForList", forIndexPath: indexPath)
                as? UITableViewCell
            
            var model = memberList[indexPath.row]

        }
        
     
  
        
        
        return cell!
    }
}
