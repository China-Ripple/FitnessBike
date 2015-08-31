//
//  FriendRecommenderViewController.swift
//  FitnessBike
//
//  Created by 钟其鸿 on 15/8/31.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

func CGMakeSize(width:CGFloat,  height:CGFloat)->CGSize
{
    //先得到appdelegate
    var app = UIApplication.sharedApplication().delegate as! AppDelegate
    var rect:CGSize = CGSize();
    //如果使用此结构体，那么对传递过来的参数，在内部做了比例系数的改变
    rect.width = width * app.baseX;//宽的改变
    rect.height = height * app.baseY;//搞得改变
    return rect;
}

func CGMakeRect(x:CGFloat,y:CGFloat, width:CGFloat, height:CGFloat)->CGRect
{
    //先得到appdelegate
    var app = UIApplication.sharedApplication().delegate as! AppDelegate
    var rect:CGRect = CGRect()
    //如果使用此结构体，那么对传递过来的参数，在内部做了比例系数的改变
    rect.origin.x = x * app.baseX;//原点的X坐标的改变
    rect.origin.y = y * app.baseY;//原点的Y坐标的改变
    rect.size.width = width * app.baseX;//宽的改变
    rect.size.height = height * app.baseY;//搞得改变
    return rect;
}


class FriendRecommenderViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{

   
    
    var headerTitle:UILabel!
    let TITLE_TAG:Int = 1000
    let BUTTON_TAG:Int = 1001

    override func viewDidLoad() {
       
        super.viewDidLoad()
       

        var searchbar:UISearchBar = UISearchBar(frame: CGMakeRect(0, 65, 375, 60))
        self.view.addSubview(searchbar)
        
        
        
        var layout = UICollectionViewFlowLayout();
        layout.headerReferenceSize = CGMakeSize(320, 40);
        layout.itemSize = CGMakeSize(160, 160);
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 20, 20);
        
        var collection = UICollectionView(frame: CGMakeRect(0, 120, 375,667), collectionViewLayout: layout)
        
        collection.dataSource = self;
        collection.delegate = self;
        collection.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(collection)
        
        
        collection.registerClass(FriendRecommenderCollectionCell.self, forCellWithReuseIdentifier: "friendCell")
        
        collection.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        
        
        collection.bounces = false;

        
        
       
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return  4
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 2
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
           var cell:FriendRecommenderCollectionCell? = collectionView.dequeueReusableCellWithReuseIdentifier("friendCell",forIndexPath: indexPath) as? FriendRecommenderCollectionCell
        
        if(cell == nil){
            
            cell = FriendRecommenderCollectionCell()

        }
        
        cell!.nameLabel.text = "宁泽涛"
        
        
        return cell!
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
        
        
        var reusableview:UICollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "header", forIndexPath: indexPath) as! UICollectionReusableView;
        
        if (kind == UICollectionElementKindSectionHeader){
            
            headerTitle = reusableview.viewWithTag(TITLE_TAG) as? UILabel
            if(headerTitle == nil){
                
                headerTitle = UILabel(frame: CGMakeRect(10, 5, 100, 30))
                
                headerTitle.tag = TITLE_TAG
            }
            reusableview.addSubview(headerTitle)
            
            if(indexPath.section == 0){
                
                 headerTitle.text = "附近的人"
            }
            else{
                headerTitle.text = "骑行达人"
            }

            reusableview.addSubview(headerTitle)
            
            var btn:FriendHeaderButton? = reusableview.viewWithTag(BUTTON_TAG) as? FriendHeaderButton
            
            if(btn != nil){
                btn!.removeFromSuperview()
            }
            else{
                btn = FriendHeaderButton()
                btn!.frame = CGMakeRect(340, 5, 20, 30)
                btn!.tag = BUTTON_TAG
                btn!.headerTitle = headerTitle.text
                btn!.index = indexPath.section
                btn!.setTitle("XXXX", forState: UIControlState.Normal)
                btn!.setImage(UIImage(named: "jiantou.png"), forState: UIControlState.Normal)
                btn!.addTarget(self,action:"onHeaderBtnClicked:", forControlEvents:UIControlEvents.TouchUpInside)
              
            }
            
            reusableview.addSubview(btn!)
        }
        
        return reusableview
    }

    func onHeaderBtnClicked(send:AnyObject?){
        println("onHeaderBtnClicked")
    }
   
    
}
