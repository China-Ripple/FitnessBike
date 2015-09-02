//
//  SearchViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/1.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var tableView:UITableView!

    var data = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGMakeRect(0, 0, 375, 667))
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setup()
        
        
    }
    
    func setup(){
        for i in 0...100{
            var model = SearchModel()
            model.userId = i
            model.userName = "Lucy \(i)"
            
            data.addObject(model)
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return CGFloat(100)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return data.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let TAG = "searchTag"
        var cell:SearchTableViewCell? = tableView.dequeueReusableCellWithIdentifier(TAG) as? SearchTableViewCell
        
        if(cell == nil){
            cell = SearchTableViewCell(style:UITableViewCellStyle.Default,reuseIdentifier:TAG)
        }
        
        var model = data.objectAtIndex(indexPath.row) as! SearchModel
        cell!.makeCell(model)
        
        return cell!
    }
}
