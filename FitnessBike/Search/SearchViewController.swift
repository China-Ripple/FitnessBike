//
//  SearchViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/9/1.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import Alamofire

enum SearchPeopleType {
    case NearbyPeople
    case Talent
    case Regulation
}

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var tableView:UITableView!
    
    var searchType:SearchPeopleType!
    
    var loading:Bool = false
    var data:[AnyObject] = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGMakeRect(0, 0, 375, 667))
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        setup()
        
        
        self.tableView.addHeaderWithCallback{
            
            self.loadData(0, isPullRefresh: true)
        }
        
        self.tableView.addFooterWithCallback{
            if(self.data.count>0) {
                var  maxId = (self.data.last!.valueForKey("id") as! String).toInt()
                
                
                self.loadData(maxId!, isPullRefresh: false)
            }
        }
        
        self.tableView.headerBeginRefreshing()
        
        
        
    }
    
    func setup(){
        for i in 0...100{
            var model = SearchModel()
            model.userId = i
            model.userName = "Lucy \(i)"
            
            data.append(model)
        }
    }
    
    
    func loadData(maxId:Int,isPullRefresh:Bool){
        if self.loading {
            return
        }
        self.loading = true
        var request:URLRequestConvertible = Router.NearbyPeople(maxId: maxId, num: 10)
        if(searchType == .NearbyPeople){
            request = Router.NearbyPeople(maxId: maxId, num: 10)
        }
        else if(searchType == .Talent){
            request = Router.Talent(maxId: maxId, num: 10)
        }
        
        Alamofire.request(request).responseJSON{
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
        
        var model = data[indexPath.row] as! SearchModel
        cell!.makeCell(model)
        
        return cell!
    }
   
}
