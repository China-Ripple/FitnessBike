//
//  AlertPickerViewController.swift
//  lll
//
//  Created by 钟其鸿 on 15/7/6.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit


protocol AlertPickerViewControllerDelegate : NSObjectProtocol {
    func didSelect()
    func didCancel()
}


class AlertPickerViewController: NSObject {
    
    
    var mUIViewController:UIViewController?
    var mViewControllerDelegate:AlertPickerViewControllerDelegate?
    
    var dataSource: UIPickerViewDataSource? // default is nil. weak reference
    var delegate: UIPickerViewDelegate? // default is nil. weak reference
    
    var picker: UIPickerView!
    
    override init(){
        
    }
    
    
    func showPickerInActionSheet(tag:Int) {
        
        
        var title = ""
        var message = "\n\n\n\n\n\n\n\n\n\n";
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet);
        alert.modalInPopover = true;
        //Create a frame (placeholder/wrapper) for the picker and then create the picker
        //var pickerFrame: CGRect = CGRectMake(17, 52, 270, 100); // CGRectMake(left), top, width, height) - left and top are like margins
        picker = UIPickerView();
        var pickerFrame: CGRect = CGRectMake(0, 52, 300, 100); // CGRectMake(left), top, width,
        picker.frame = pickerFrame
        alert.view.addSubview(picker);
        
        
        picker.tag=tag
        
        //set the pickers datasource and delegate

        picker.delegate = delegate ;
        picker.dataSource = dataSource;
        
        //Add the picker to the alert controller
        
        
        //Create the toolbar view - the view witch will hold our 2 buttons
        var toolFrame = CGRectMake(17, 5, 270, 45);
        var toolView: UIView = UIView(frame: toolFrame);
        
        //add buttons to the view
        var buttonCancelFrame: CGRect = CGRectMake(0, 7, 100, 30); //size & position of the button as placed on the toolView
        //Create the cancel button & set its title
        var buttonCancel: UIButton = UIButton(frame: buttonCancelFrame);
        buttonCancel.setTitle("Cancel", forState: UIControlState.Normal);
        buttonCancel.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        toolView.addSubview(buttonCancel); //add it to the toolView
        
        //Add the target - target, function to call, the event witch will trigger the function call
        buttonCancel.addTarget(self, action: "cancelSelection:", forControlEvents: UIControlEvents.TouchDown);
        
        
        //add buttons to the view
        var buttonOkFrame: CGRect = CGRectMake(170, 7, 100, 30); //size & position of the button as placed on the toolView
        //Create the Select button & set the title
        var buttonOk: UIButton = UIButton(frame: buttonOkFrame);
        buttonOk.setTitle("Select", forState: UIControlState.Normal);
        buttonOk.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        toolView.addSubview(buttonOk); //add to the subview
        
        //Add the tartget. In my case I dynamicly set the target of the select button
        
         buttonOk.addTarget(self, action: "confirmSelection:", forControlEvents: UIControlEvents.TouchDown);
        
        
        //add the toolbar to the alert controller
        alert.view.addSubview(toolView);
        
        mUIViewController!.presentViewController(alert, animated: true, completion: nil);
    }
    
    func confirmSelection(sender: UIButton){
        
       if let delegate = mViewControllerDelegate{
            delegate.didSelect()
        }

        mUIViewController!.dismissViewControllerAnimated(true, completion: nil);
        
    }
    
   func cancelSelection(sender: UIButton){
    
    if let delegate = mViewControllerDelegate{
        delegate.didCancel()
    }

        mUIViewController!.dismissViewControllerAnimated(true, completion: nil);
        // We dismiss the alert. Here you can add your additional code to execute when cancel is pressed
    }
    
    func getPicker()->UIPickerView{
        
        return picker
    }

}
