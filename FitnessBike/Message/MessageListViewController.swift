//
//  MessageListViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/1.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import Alamofire
class MessageListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var tableView:UITableView!
    var messageData = NSMutableArray()
    internal var data:[AnyObject] = [AnyObject]()
    var msgItem:UIImageView!
    var viewsHiden = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "消息"
        tableView = UITableView(frame: CGMakeRect(0, 0, 375, 667))
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
     
        
        setupData()
        
        self.tableView.addHeaderWithCallback{
            
            self.loadData(0, isPullRefresh: true)
        }
        
        self.tableView.addFooterWithCallback{
            
            if(self.data.count>0) {
                var  maxId = self.data.last!.valueForKey("id") as! Int

                
                self.loadData(Int(maxId), isPullRefresh: false)
            }
            else{
                self.loadData(0, isPullRefresh: false)
            }
        }
        self.tableView.headerBeginRefreshing()
        
    }
    
    override func viewWillAppear(animated: Bool){
//        if viewsHiden == true{
//            msgItem.hidden = false
//        }
//        else
    
 //           layoutNavigationBar()
        
        
        super.viewWillAppear(animated)
        
        
    }
    
    
    
    
    
    override func viewWillDisappear(animated: Bool) {
       // cleanNavigationBar()
        super.viewWillDisappear(animated)
    }
    
    func cleanNavigationBar(){
        viewsHiden = true
        msgItem.hidden = true
    }
    
    func layoutNavigationBar(){
        
        msgItem = UIImageView(frame: CGMakeRect(300, 0, 30, 30))
        msgItem.image = UIImage(named: "item_ctrl_press")
        
        //msgItem.setBackgroundImage(UIImage(named: "message"), forState: UIControlState.Normal)
        //msgItem.addTarget(self, action: "checkMessage:", forControlEvents: UIControlEvents.TouchUpInside)
        //  添加到到导航栏上
        
        if let tv = self.navigationController!.navigationBar.topItem!.titleView {
            
            tv.removeFromSuperview()
        }
        self.navigationController!.navigationBar.topItem!.titleView = msgItem
        
      

    }
    
    func setupData(){
        for i in 0...20{
            var model = MessageModel()
            model.defierId = i%4
            model.defierName = "张含韵"
            messageData.addObject(model)
        }
        
        
    }
    
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return messageData.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return CGFloat(70)
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellTag = "messageCell"
        
        var cell:MessageTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellTag) as? MessageTableViewCell
        
        if(cell == nil){
            cell = MessageTableViewCell(style:UITableViewCellStyle.Default,reuseIdentifier: cellTag)
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
        }
        
        
        var model = messageData.objectAtIndex(indexPath.row) as! MessageModel
        cell!.makeCell(model)
        
                      
        return cell!
    }
    
    
    func loadData(maxId:Int,isPullRefresh:Bool){
        
        Alamofire.request(Router.CompMsg(maxId: maxId,num: 20)).responseJSON{
            (_,_,json,error) in
            
            
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
            
            if(result["response"].stringValue == "error") {
                
                
            }
            else{
                
                var items = result["people"].object as! [AnyObject]
                
                if(items.count==0){
                    return
                }
                
                
                if(isPullRefresh){
                    
                    self.data.removeAll(keepCapacity: false)
                }
                
                for  it in items {
                    
                    self.data.append(it)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
   
}
