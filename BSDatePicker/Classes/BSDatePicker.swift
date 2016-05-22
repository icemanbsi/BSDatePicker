//
//  BSDatePicker.swift
//  V1.1
//  update : setDate parameter optional, getDate optional
//
//
//  Created by Bobby Stenly Irawan ( iceman.bsi@gmail.com - http://bobbystenly.com ) on 11/22/15.
//  Copyright © 2015 Bobby Stenly Irawan. All rights reserved.
//

import Foundation
import UIKit

public class BSDatePicker:UIButton {
    //required attributes
    public var viewController: UIViewController?
    //--end of required attributes
    
    //optional attributes
    public var modalBackgroundColor: UIColor = UIColor(white: 0, alpha: 0.5)
    public var headerBackgroundColor: UIColor = UIColor(white: 0, alpha: 1)
    public var titleColor: UIColor = UIColor(white: 1, alpha: 1)
    public var cancelButtonBackgroundColor: UIColor = UIColor(white: 0, alpha: 0)
    public var doneButtonBackgroundColor: UIColor = UIColor(white: 0, alpha: 0)
    public var cancelTextColor: UIColor = UIColor(white: 0.8, alpha: 1)
    public var doneTextColor: UIColor = UIColor(white: 0.8, alpha: 1)
    public var titleFont:UIFont? = UIFont(name: "Helvetica", size: 16)
    public var buttonFont:UIFont? = UIFont(name: "Helvetica", size: 13)
    public var title: String = "title"
    public var cancelButtonTitle: String = "Cancel"
    public var doneButtonTitle: String = "Done"
    public var defaultTitle: String = "Select Item"
    public var datePickerMode: UIDatePickerMode = UIDatePickerMode.Date
    public var dateFormat: String = "d MMMM YYYY"
    //-- end of optional attributes
    
    private var selectedDate: NSDate?
    private var dateFormatter: NSDateFormatter = NSDateFormatter()
    
    private var selectorModalView: UIView!
    private var selectorView: UIView!
    private var selectorHeaderView: UIView!
    private var lblSelectorTitleLabel: UILabel!
    private var btnSelectorCancel: UIButton!
    private var btnSelectorDone: UIButton!
    private var selectorDatePicker: UIDatePicker!
    
    public func setup(){
        if let vc = self.viewController {
            
            self.selectorModalView = UIView()
            self.selectorModalView.backgroundColor = self.modalBackgroundColor
            self.selectorModalView.translatesAutoresizingMaskIntoConstraints = false
            vc.view.addSubview(self.selectorModalView)
            vc.view.addConstraint(NSLayoutConstraint(item: self.selectorModalView,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: vc.view,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1,
                constant: 0))
            vc.view.addConstraint(NSLayoutConstraint(item: self.selectorModalView,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: NSLayoutRelation.Equal,
                toItem: vc.view,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1,
                constant: 0))
            vc.view.addConstraint(NSLayoutConstraint(item: self.selectorModalView,
                attribute: NSLayoutAttribute.Trailing,
                relatedBy: NSLayoutRelation.Equal,
                toItem: vc.view,
                attribute: NSLayoutAttribute.Trailing,
                multiplier: 1,
                constant: 0))
            vc.view.addConstraint(NSLayoutConstraint(item: self.selectorModalView,
                attribute: NSLayoutAttribute.Leading,
                relatedBy: NSLayoutRelation.Equal,
                toItem: vc.view,
                attribute: NSLayoutAttribute.Leading,
                multiplier: 1,
                constant: 0))
            
            self.selectorView = UIView()
            self.selectorView.backgroundColor = UIColor(white: 1, alpha: 1)
            self.selectorView.translatesAutoresizingMaskIntoConstraints = false
            self.selectorModalView.addSubview(self.selectorView)
            self.selectorModalView.addConstraint(NSLayoutConstraint(item: self.selectorView,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorModalView,
                attribute: NSLayoutAttribute.CenterY,
                multiplier: 1,
                constant: 0))
            self.selectorModalView.addConstraint(NSLayoutConstraint(item: self.selectorView,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorModalView,
                attribute: NSLayoutAttribute.CenterX,
                multiplier: 1,
                constant: 0))
            self.selectorModalView.addConstraint(NSLayoutConstraint(item: self.selectorView,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1,
                constant: 270))
            
            self.selectorHeaderView = UIView()
            self.selectorHeaderView.backgroundColor = self.headerBackgroundColor
            self.selectorHeaderView.translatesAutoresizingMaskIntoConstraints = false
            self.selectorView.addSubview(self.selectorHeaderView)
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorHeaderView,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorView,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1,
                constant: 0))
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorHeaderView,
                attribute: NSLayoutAttribute.Leading,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorView,
                attribute: NSLayoutAttribute.Leading,
                multiplier: 1,
                constant: 0))
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorHeaderView,
                attribute: NSLayoutAttribute.Trailing,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorView,
                attribute: NSLayoutAttribute.Trailing,
                multiplier: 1,
                constant: 0))
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorHeaderView,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1,
                constant: 56))
            
            self.lblSelectorTitleLabel = UILabel()
            self.lblSelectorTitleLabel.text = self.title
            self.lblSelectorTitleLabel.textColor = self.titleColor
            if let font = self.titleFont {
                self.lblSelectorTitleLabel.font = font
            }
            self.lblSelectorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.selectorHeaderView.addSubview(self.lblSelectorTitleLabel)
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.lblSelectorTitleLabel,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.CenterX,
                multiplier: 1,
                constant: 0))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.lblSelectorTitleLabel,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.CenterY,
                multiplier: 1,
                constant: 0))
            
            self.btnSelectorCancel = UIButton()
            self.btnSelectorCancel.setTitle(self.cancelButtonTitle, forState: UIControlState.Normal)
            self.btnSelectorCancel.titleLabel?.textColor = self.cancelTextColor
            self.btnSelectorCancel.backgroundColor = self.cancelButtonBackgroundColor
            self.btnSelectorCancel.titleLabel?.textAlignment = NSTextAlignment.Left
            if let font = self.buttonFont {
                self.btnSelectorCancel.titleLabel?.font = font
            }
            self.btnSelectorCancel.translatesAutoresizingMaskIntoConstraints = false
            self.selectorHeaderView.addSubview(self.btnSelectorCancel)
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorCancel,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1,
                constant: 8))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorCancel,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1,
                constant: -8))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorCancel,
                attribute: NSLayoutAttribute.Leading,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.Leading,
                multiplier: 1,
                constant: 8))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorCancel,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1,
                constant: 40))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorCancel,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1,
                constant: 50))
            
            self.btnSelectorDone = UIButton()
            self.btnSelectorDone.setTitle(self.doneButtonTitle, forState: UIControlState.Normal)
            self.btnSelectorDone.titleLabel?.textColor = self.doneTextColor
            self.btnSelectorDone.backgroundColor = self.doneButtonBackgroundColor
            self.btnSelectorDone.titleLabel?.textAlignment = NSTextAlignment.Right
            if let font = self.buttonFont {
                self.btnSelectorDone.titleLabel?.font = font
            }
            self.btnSelectorDone.translatesAutoresizingMaskIntoConstraints = false
            self.selectorHeaderView.addSubview(self.btnSelectorDone)
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorDone,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1,
                constant: 8))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorDone,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1,
                constant: -8))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorDone,
                attribute: NSLayoutAttribute.Trailing,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.Trailing,
                multiplier: 1,
                constant: -8))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorDone,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1,
                constant: 40))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorDone,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1,
                constant: 50))
            
            self.selectorDatePicker = UIDatePicker()
            self.selectorDatePicker.translatesAutoresizingMaskIntoConstraints = false
            self.selectorView.addSubview(self.selectorDatePicker)
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorDatePicker,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1,
                constant: 0))
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorDatePicker,
                attribute: NSLayoutAttribute.Leading,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorView,
                attribute: NSLayoutAttribute.Leading,
                multiplier: 1,
                constant: 0))
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorDatePicker,
                attribute: NSLayoutAttribute.Trailing,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorView,
                attribute: NSLayoutAttribute.Trailing,
                multiplier: 1,
                constant: 0))
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorDatePicker,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.selectorView,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1,
                constant: 0))
            
            self.btnSelectorCancel.addTarget(self, action: #selector(BSDatePicker.btnSelectorCancelTouched(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.btnSelectorDone.addTarget(self, action: #selector(BSDatePicker.btnSelectorDoneTouched(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.addTarget(self, action: #selector(BSDatePicker.bsdpClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.selectorModalView.hidden = true
            self.setTitle(self.defaultTitle, forState: UIControlState.Normal)
            
            self.selectorDatePicker.datePickerMode = self.datePickerMode
            self.dateFormatter.dateFormat = self.dateFormat
        }
        else{
            NSLog("BSDatePicker Error : Please set the ViewController first")
        }
    }
    
    public func btnSelectorCancelTouched(sender: AnyObject){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.selectorModalView.alpha = 0
            }, completion: { (Bool) -> Void in
                self.selectorModalView.hidden = true
        })
    }
    
    public func btnSelectorDoneTouched(sender: AnyObject){
        //set title
        self.selectedDate = self.selectorDatePicker.date
        self.setTitle(self.dateFormatter.stringFromDate(self.selectedDate!), forState: UIControlState.Normal)
        self.btnSelectorCancelTouched(sender)
    }
    
    public func bsdpClicked(sender: AnyObject){
        if let vc = self.viewController {
            if let date = self.selectedDate {
                self.selectorDatePicker.setDate(date, animated: false)
            }
            else{
                self.selectorDatePicker.setDate(NSDate(), animated: false)
            }
            self.selectorModalView.hidden = false
            self.selectorModalView.alpha = 0
            vc.view.bringSubviewToFront(self.selectorModalView)
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.selectorModalView.alpha = 1
            })
        }
    }
    
    
    //public get set
    
    public func setDate(date: NSDate?) {
        self.selectedDate = date
        
        if let selDate = self.selectedDate {
            self.setTitle(self.dateFormatter.stringFromDate(selDate), forState: UIControlState.Normal)
        }
        else {
            self.setTitle(self.defaultTitle, forState: UIControlState.Normal)
        }
    }
    
    public func getDate() -> NSDate? {
        return self.selectedDate
    }
}
