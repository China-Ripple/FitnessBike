//
//  ActivityViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/17.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import Alamofire
class ActivityViewController: UIViewController {
    
    var tableView: UITableView!
    var activities:NSMutableArray! = NSMutableArray()
    
    let cellTag = "ActivityBriefTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var paddingTop = self.navigationController!.navigationBar.frame.height + Utility.getStatusHeight()
        
        tableView = UITableView(frame: CGRectMake(0, paddingTop, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Plain)
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        for  i in 0...30 {
            
            var model = ActivityBriefModel()
            model.title = "Title:\(i)"
            model.subTitle="SubTitle:\(i)"
            
            activities.addObject(model)
            
        }
        
        
        self.tableView.addHeaderWithCallback{
            
            self.loadData(0,maxId:0, isPullRefresh: true)
        }
        
        self.tableView.addFooterWithCallback{
            
//            if(self.data.count>0) {
//                var  maxId = self.data.last!.valueForKey("bookId") as! Int
//                self.loadData(self.GetBookType(),maxId:maxId, isPullRefresh: false)
//            }
            
             self.loadData(0,maxId:0, isPullRefresh: true)
        }
        
        self.tableView.headerBeginRefreshing()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func loadData(type:Int,maxId:Int,isPullRefresh:Bool){
//        
//        Alamofire.request(Router.BookList(type: type, maxId: maxId, count: 16)).responseJSON{
        
        
        
        Alamofire.request(Router.AllRanking(maxId: maxId, num:10)).responseJSON{
            (_,_,json,error) in
            
            
            if(isPullRefresh){
                self.tableView.headerEndRefreshing()
            }
            else{
                self.tableView.footerEndRefreshing()
            }
            if error != nil {
                return
            }
            
            
            
            var result = JSON(json!)
            
            if result["isSuc"].boolValue {
                
                var items = result["result"].object as! [AnyObject]
                
                if(items.count==0){
                    return
                }
                
                
                
              // self.setBookData(items,type:type,isPullRefresh:isPullRefresh)
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
                
                
                
            }
        }
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

extension ActivityViewController:UITableViewDataSource,UITableViewDelegate{
    
    
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return 100
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return activities.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell:ActivityBriefTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellTag) as? ActivityBriefTableViewCell
        
         if(cell == nil){
            
            cell = ActivityBriefTableViewCell(style:UITableViewCellStyle.Default,reuseIdentifier: cellTag)
        
            cell!.titleLabel.font = UIFont.systemFontOfSize(14)
            cell!.selectionStyle = .Gray
            cell!.accessoryType = .DisclosureIndicator;
            
        
        }
        
        
        
        
        var model = activities.objectAtIndex(indexPath.row)
        
        cell?.showActivity(model as! ActivityBriefModel)
        
        
        
        
        
        return cell!
        
    }
}
