//
//  MessageListViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/1.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class MessageListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var tableView:UITableView!
    var messageData = NSMutableArray()
    
    var msgItem:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGMakeRect(0, 0, 375, 667))
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
     
        
        setupData()
        
        
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
        
        msgItem.removeFromSuperview()
    }
    
    func layoutNavigationBar(){
        msgItem=UIButton(frame: CGMakeRect(180, 10, 30, 30))
        msgItem.setBackgroundImage(UIImage(named: "message"), forState: UIControlState.Normal)
        //msgItem.addTarget(self, action: "checkMessage:", forControlEvents: UIControlEvents.TouchUpInside)
        //  添加到到导航栏上
        self.navigationController!.navigationBar.addSubview(msgItem)

    }
    
    func setupData(){
        for i in 0...20{
            var model = MessageModel()
            model.defierId = i%3
            model.defierName = "宁泽涛"
            
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
    
    func setupNavigationBar(){
        
    }
}
