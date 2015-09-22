//  AnimationTabBarController.swift
//
// Copyright (c) 11/10/14 Ramotion Inc. (http://ramotion.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

class RAMAnimatedTabBarItem: UITabBarItem {
    
    var animation: RAMItemAnimation = RAMBounceAnimation()
    
    @IBInspectable var textColor = UIColor.whiteColor()
    
    func playAnimation(icon: UIImageView, textLabel: UILabel){
        
        animation.playAnimation(icon, textLabel: textLabel)
    }
    
    func deselectAnimation(icon: UIImageView, textLabel: UILabel) {
        animation.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: textColor)
    }
    
    func selectedState(icon: UIImageView, textLabel: UILabel) {
        
        animation.selectedState(icon, textLabel: textLabel)
    }
}

var tabBarHeight:CGFloat = 0

class RAMAnimatedTabBarController: UITabBarController {
    
    var iconsView: [(icon: UIImageView, textLabel: UILabel)] = []
    var tabBarItems:[AnyObject] = [AnyObject]()
    
    // MARK: life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        createViewControllers()
        
        let containers = createViewContainers()
        
        createCustomIcons(containers)
    }
    
    class func getHeight(){
        
    }
    
    func createViewControllers(){
        
        var scale:CGFloat = 0.6
        
        var vc1 = CtrlViewController()
        var vc2 = PersonViewController()
        var vc3 = RankingViewController()
        var vc4 = ActivityViewController()
        selectedIndex = 0
        self.viewControllers = [vc1,vc2,vc3,vc4]
        
        
        var item1 = RAMAnimatedTabBarItem()
        var img1:UIImage! =   UIImage(named: "item_ctrl_normal")
        item1.image = ImageUtil.scaleImage(CGSizeMake(img1.size.width*scale, img1.size.height*scale), img:img1)
        
        item1.title = "控制"
        tabBarItems.append(item1)
        
        var item2 = RAMAnimatedTabBarItem()
        var img2:UIImage! =   UIImage(named: "item_person_normal")
        item2.image = ImageUtil.scaleImage(CGSizeMake(img2.size.width*scale, img2.size.height*scale), img:img2)
        item2.title = "个人中心"
        tabBarItems.append(item2)
        
        
        var item3 = RAMAnimatedTabBarItem()
        var img3:UIImage! =   UIImage(named: "item_ranking_normal")
        item3.title = "竞赛"
        item3.image = ImageUtil.scaleImage(CGSizeMake(img3.size.width*scale, img3.size.height*scale), img:img3)
        tabBarItems.append(item3)
        
        
        var item4 = RAMAnimatedTabBarItem()
        var img4:UIImage! =   UIImage(named: "item_activity_normal")
        item4.image = ImageUtil.scaleImage(CGSizeMake(img4.size.width*scale, img4.size.height*scale), img:img4)
        item4.title = "活动"
        tabBarItems.append(item4)
        
        
       
        
    }
    
    // MARK: create methods
    
    func createCustomIcons(containers : [String: UIView]) {
        
        if let items = tabBarItems as? [RAMAnimatedTabBarItem] {
            
            let itemsCount = items.count as Int - 1
            
            for (index, item) in enumerate(items) {
                
                assert(item.image != nil, "add image icon in UITabBarItem")
                
                
                
                if let container = containers["container\(itemsCount-index)"]
                {
                    container.tag = index
                    
                    let icon = UIImageView(image: item.image)
                    icon.setTranslatesAutoresizingMaskIntoConstraints(false)
                    icon.tintColor = UIColor.clearColor()
                    
                    // text
                    let textLabel = UILabel()
                    textLabel.text = item.title
                    textLabel.backgroundColor = UIColor.clearColor()
                    //textLabel.textColor = item.textColor
                    textLabel.font = UIFont.systemFontOfSize(10)
                    textLabel.textAlignment = NSTextAlignment.Center
                    textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
                    
                    container.addSubview(icon)
                    
                    if let itemImage = item.image {
                        createConstraints(icon, container: container, size: itemImage.size, yOffset: -5)
                    }
                    
                    container.addSubview(textLabel)
                    
                    if let tabBarItem = tabBar.items {
                        let textLabelWidth = tabBar.frame.size.width / CGFloat(tabBarItem.count) - 5.0
                        createConstraints(textLabel, container: container, size: CGSize(width: textLabelWidth , height: 10), yOffset: 16)
                    }
                    
                    let iconsAndLabels = (icon:icon, textLabel:textLabel)
                    iconsView.append(iconsAndLabels)
                    
                    if 0 == index { // selected first elemet
                        item.selectedState(icon, textLabel: textLabel)
                    }
                    
                    item.image = nil
                    item.title = ""
                }
                else{
                    print("No container given")
                    continue
                }
                
            }
        }
    }
    
    func createConstraints(view: UIView, container: UIView, size: CGSize, yOffset: CGFloat) {
        
        let constX = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: container,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1,
            constant: 0)
        container.addConstraint(constX)
        
        let constY = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: container,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1,
            constant: yOffset)
        container.addConstraint(constY)
        
        let constW = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: size.width)
        view.addConstraint(constW)
        
        let constH = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: size.height)
        view.addConstraint(constH)
    }
    
    func createViewContainers() -> [String: UIView] {
        
        
        
        
        var containersDict = [String:UIView]()
        
        
        
        let itemsCount: Int = tabBarItems.count - 1
        
        for index in 0...itemsCount {
            let viewContainer = createViewContainer()
            containersDict["container\(index)"] = viewContainer
        }
        
        var formatString = "H:|-(0)-[container0]"
        for index in 1...itemsCount {
            formatString += "-(0)-[container\(index)(==container0)]"
        }
        formatString += "-(0)-|"
        let constranints = NSLayoutConstraint.constraintsWithVisualFormat(formatString,
            options:NSLayoutFormatOptions.DirectionRightToLeft,
            metrics: nil,
            views: containersDict)
        view.addConstraints(constranints)
        
        
        
        
        return containersDict
    }
    
    func createViewContainer() -> UIView {
        let viewContainer = UIView()
        viewContainer.backgroundColor = UIColor.clearColor() // for test
        //viewContainer.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(viewContainer)
        
        // add gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapHandler:")
        tapGesture.numberOfTouchesRequired = 1
        viewContainer.addGestureRecognizer(tapGesture)
        
        
        // add constrains
        let constY = NSLayoutConstraint(item: viewContainer,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1,
            constant: 0)
        
        view.addConstraint(constY)
        
        let constH = NSLayoutConstraint(item: viewContainer,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: tabBar.frame.size.height)
        viewContainer.addConstraint(constH)
        
        tabBarHeight = viewContainer.frame.size.height
        
        return viewContainer
    }
    
    // MARK: actions
    
    func tapHandler(gesture:UIGestureRecognizer) {
        
        let items = tabBarItems as! [RAMAnimatedTabBarItem]
        
        let currentIndex = gesture.view!.tag
        if selectedIndex != currentIndex {
            let animationItem : RAMAnimatedTabBarItem = items[currentIndex]
            let icon = iconsView[currentIndex].icon
            let textLabel = iconsView[currentIndex].textLabel
            animationItem.playAnimation(icon, textLabel: textLabel)
            
            let deselelectIcon = iconsView[selectedIndex].icon
            let deselelectTextLabel = iconsView[selectedIndex].textLabel
            let deselectItem = items[selectedIndex]
            deselectItem.deselectAnimation(deselelectIcon, textLabel: deselelectTextLabel)
            
            selectedIndex = gesture.view!.tag
        }
    }
    
    func setSelectIndex(from from: Int,to: Int) {
        selectedIndex = to
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        items[from].deselectAnimation(iconsView[from].icon, textLabel: iconsView[from].textLabel)
        items[to].playAnimation(iconsView[to].icon, textLabel: iconsView[to].textLabel)
    }
}


