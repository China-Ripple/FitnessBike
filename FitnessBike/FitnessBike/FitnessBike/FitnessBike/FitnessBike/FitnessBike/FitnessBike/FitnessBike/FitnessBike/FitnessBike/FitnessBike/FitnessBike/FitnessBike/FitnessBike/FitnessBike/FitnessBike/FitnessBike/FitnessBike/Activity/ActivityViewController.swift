//
//  ActivityViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/17.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var activities:NSMutableArray! = NSMutableArray()
    
    let cellTag = "ActivityBriefTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        for  i in 0...30 {
            
            var model = ActivityBriefModel()
            model.title = "Title:\(i)"
            model.subTitle="SubTitle:\(i)"
            
            activities.addObject(model)
            
        }
        
        

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
