//
//  BSDatePicker.swift
//  V2.0
//  update 09/20/16 : updated to swift 3
//
//
//  Created by Bobby Stenly Irawan ( iceman.bsi@gmail.com - http://bobbystenly.com ) on 11/22/15.
//  Copyright © 2016 Bobby Stenly Irawan. All rights reserved.
//

import Foundation
import UIKit

open class BSDatePicker:UIButton {
    //required attributes
    open var viewController: UIViewController?
    //--end of required attributes
    
    //optional attributes
    open var modalBackgroundColor: UIColor = UIColor(white: 0, alpha: 0.5)
    open var headerBackgroundColor: UIColor = UIColor(white: 0, alpha: 1)
    open var titleColor: UIColor = UIColor(white: 1, alpha: 1)
    open var cancelButtonBackgroundColor: UIColor = UIColor(white: 0, alpha: 0)
    open var doneButtonBackgroundColor: UIColor = UIColor(white: 0, alpha: 0)
    open var cancelTextColor: UIColor = UIColor(white: 0.8, alpha: 1)
    open var doneTextColor: UIColor = UIColor(white: 0.8, alpha: 1)
    open var titleFont:UIFont? = UIFont(name: "Helvetica", size: 16)
    open var buttonFont:UIFont? = UIFont(name: "Helvetica", size: 13)
    open var title: String = "title"
    open var cancelButtonTitle: String = "Cancel"
    open var doneButtonTitle: String = "Done"
    open var defaultTitle: String = "Select Item"
    open var datePickerMode: UIDatePickerMode = UIDatePickerMode.date
    open var dateFormat: String = "d MMMM YYYY"
    //-- end of optional attributes
    
    fileprivate var selectedDate: Date?
    fileprivate var dateFormatter: DateFormatter = DateFormatter()
    
    fileprivate var selectorModalView: UIView!
    fileprivate var selectorView: UIView!
    fileprivate var selectorHeaderView: UIView!
    fileprivate var lblSelectorTitleLabel: UILabel!
    fileprivate var btnSelectorCancel: UIButton!
    fileprivate var btnSelectorDone: UIButton!
    fileprivate var selectorDatePicker: UIDatePicker!
    
    open func setup(){
        if let vc = self.viewController {
            
            self.selectorModalView = UIView()
            self.selectorModalView.backgroundColor = self.modalBackgroundColor
            self.selectorModalView.translatesAutoresizingMaskIntoConstraints = false
            vc.view.addSubview(self.selectorModalView)
            vc.view.addConstraint(NSLayoutConstraint(item: self.selectorModalView,
                attribute: NSLayoutAttribute.top,
                relatedBy: NSLayoutRelation.equal,
                toItem: vc.view,
                attribute: NSLayoutAttribute.top,
                multiplier: 1,
                constant: 0))
            vc.view.addConstraint(NSLayoutConstraint(item: self.selectorModalView,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: NSLayoutRelation.equal,
                toItem: vc.view,
                attribute: NSLayoutAttribute.bottom,
                multiplier: 1,
                constant: 0))
            vc.view.addConstraint(NSLayoutConstraint(item: self.selectorModalView,
                attribute: NSLayoutAttribute.trailing,
                relatedBy: NSLayoutRelation.equal,
                toItem: vc.view,
                attribute: NSLayoutAttribute.trailing,
                multiplier: 1,
                constant: 0))
            vc.view.addConstraint(NSLayoutConstraint(item: self.selectorModalView,
                attribute: NSLayoutAttribute.leading,
                relatedBy: NSLayoutRelation.equal,
                toItem: vc.view,
                attribute: NSLayoutAttribute.leading,
                multiplier: 1,
                constant: 0))
            
            self.selectorView = UIView()
            self.selectorView.backgroundColor = UIColor(white: 1, alpha: 1)
            self.selectorView.translatesAutoresizingMaskIntoConstraints = false
            self.selectorModalView.addSubview(self.selectorView)
            self.selectorModalView.addConstraint(NSLayoutConstraint(item: self.selectorView,
                attribute: NSLayoutAttribute.centerY,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorModalView,
                attribute: NSLayoutAttribute.centerY,
                multiplier: 1,
                constant: 0))
            self.selectorModalView.addConstraint(NSLayoutConstraint(item: self.selectorView,
                attribute: NSLayoutAttribute.centerX,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorModalView,
                attribute: NSLayoutAttribute.centerX,
                multiplier: 1,
                constant: 0))
            self.selectorModalView.addConstraint(NSLayoutConstraint(item: self.selectorView,
                attribute: NSLayoutAttribute.width,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 1,
                constant: 270))
            
            self.selectorHeaderView = UIView()
            self.selectorHeaderView.backgroundColor = self.headerBackgroundColor
            self.selectorHeaderView.translatesAutoresizingMaskIntoConstraints = false
            self.selectorView.addSubview(self.selectorHeaderView)
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorHeaderView,
                attribute: NSLayoutAttribute.top,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorView,
                attribute: NSLayoutAttribute.top,
                multiplier: 1,
                constant: 0))
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorHeaderView,
                attribute: NSLayoutAttribute.leading,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorView,
                attribute: NSLayoutAttribute.leading,
                multiplier: 1,
                constant: 0))
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorHeaderView,
                attribute: NSLayoutAttribute.trailing,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorView,
                attribute: NSLayoutAttribute.trailing,
                multiplier: 1,
                constant: 0))
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorHeaderView,
                attribute: NSLayoutAttribute.height,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
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
                attribute: NSLayoutAttribute.centerX,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.centerX,
                multiplier: 1,
                constant: 0))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.lblSelectorTitleLabel,
                attribute: NSLayoutAttribute.centerY,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.centerY,
                multiplier: 1,
                constant: 0))
            
            self.btnSelectorCancel = UIButton()
            self.btnSelectorCancel.setTitle(self.cancelButtonTitle, for: UIControlState())
            self.btnSelectorCancel.titleLabel?.textColor = self.cancelTextColor
            self.btnSelectorCancel.backgroundColor = self.cancelButtonBackgroundColor
            self.btnSelectorCancel.titleLabel?.textAlignment = NSTextAlignment.left
            if let font = self.buttonFont {
                self.btnSelectorCancel.titleLabel?.font = font
            }
            self.btnSelectorCancel.translatesAutoresizingMaskIntoConstraints = false
            self.selectorHeaderView.addSubview(self.btnSelectorCancel)
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorCancel,
                attribute: NSLayoutAttribute.top,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.top,
                multiplier: 1,
                constant: 8))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorCancel,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.bottom,
                multiplier: 1,
                constant: -8))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorCancel,
                attribute: NSLayoutAttribute.leading,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.leading,
                multiplier: 1,
                constant: 8))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorCancel,
                attribute: NSLayoutAttribute.height,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 1,
                constant: 40))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorCancel,
                attribute: NSLayoutAttribute.width,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 1,
                constant: 50))
            
            self.btnSelectorDone = UIButton()
            self.btnSelectorDone.setTitle(self.doneButtonTitle, for: UIControlState())
            self.btnSelectorDone.titleLabel?.textColor = self.doneTextColor
            self.btnSelectorDone.backgroundColor = self.doneButtonBackgroundColor
            self.btnSelectorDone.titleLabel?.textAlignment = NSTextAlignment.right
            if let font = self.buttonFont {
                self.btnSelectorDone.titleLabel?.font = font
            }
            self.btnSelectorDone.translatesAutoresizingMaskIntoConstraints = false
            self.selectorHeaderView.addSubview(self.btnSelectorDone)
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorDone,
                attribute: NSLayoutAttribute.top,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.top,
                multiplier: 1,
                constant: 8))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorDone,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.bottom,
                multiplier: 1,
                constant: -8))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorDone,
                attribute: NSLayoutAttribute.trailing,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.trailing,
                multiplier: 1,
                constant: -8))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorDone,
                attribute: NSLayoutAttribute.height,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 1,
                constant: 40))
            self.selectorHeaderView.addConstraint(NSLayoutConstraint(item: self.btnSelectorDone,
                attribute: NSLayoutAttribute.width,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 1,
                constant: 50))
            
            self.selectorDatePicker = UIDatePicker()
            self.selectorDatePicker.translatesAutoresizingMaskIntoConstraints = false
            self.selectorView.addSubview(self.selectorDatePicker)
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorDatePicker,
                attribute: NSLayoutAttribute.top,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorHeaderView,
                attribute: NSLayoutAttribute.bottom,
                multiplier: 1,
                constant: 0))
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorDatePicker,
                attribute: NSLayoutAttribute.leading,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorView,
                attribute: NSLayoutAttribute.leading,
                multiplier: 1,
                constant: 0))
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorDatePicker,
                attribute: NSLayoutAttribute.trailing,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorView,
                attribute: NSLayoutAttribute.trailing,
                multiplier: 1,
                constant: 0))
            self.selectorView.addConstraint(NSLayoutConstraint(item: self.selectorDatePicker,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.selectorView,
                attribute: NSLayoutAttribute.bottom,
                multiplier: 1,
                constant: 0))
            
            self.btnSelectorCancel.addTarget(self, action: #selector(BSDatePicker.btnSelectorCancelTouched(_:)), for: UIControlEvents.touchUpInside)
            self.btnSelectorDone.addTarget(self, action: #selector(BSDatePicker.btnSelectorDoneTouched(_:)), for: UIControlEvents.touchUpInside)
            self.addTarget(self, action: #selector(BSDatePicker.bsdpClicked(_:)), for: UIControlEvents.touchUpInside)
            
            self.selectorModalView.isHidden = true
            self.setTitle(self.defaultTitle, for: UIControlState())
            
            self.selectorDatePicker.datePickerMode = self.datePickerMode
            self.dateFormatter.dateFormat = self.dateFormat
        }
        else{
            NSLog("BSDatePicker Error : Please set the ViewController first")
        }
    }
    
    open func btnSelectorCancelTouched(_ sender: AnyObject){
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.selectorModalView.alpha = 0
            }, completion: { (Bool) -> Void in
                self.selectorModalView.isHidden = true
        })
    }
    
    open func btnSelectorDoneTouched(_ sender: AnyObject){
        //set title
        self.selectedDate = self.selectorDatePicker.date
        self.setTitle(self.dateFormatter.string(from: self.selectedDate!), for: UIControlState())
        self.btnSelectorCancelTouched(sender)
    }
    
    open func bsdpClicked(_ sender: AnyObject){
        if let vc = self.viewController {
            if let date = self.selectedDate {
                self.selectorDatePicker.setDate(date, animated: false)
            }
            else{
                self.selectorDatePicker.setDate(Date(), animated: false)
            }
            self.selectorModalView.isHidden = false
            self.selectorModalView.alpha = 0
            vc.view.bringSubview(toFront: self.selectorModalView)
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.selectorModalView.alpha = 1
            })
        }
    }
    
    
    //public get set
    
    open func setDate(_ date: Date?) {
        self.selectedDate = date
        
        if let selDate = self.selectedDate {
            self.setTitle(self.dateFormatter.string(from: selDate), for: UIControlState())
        }
        else {
            self.setTitle(self.defaultTitle, for: UIControlState())
        }
    }
    
    open func getDate() -> Date? {
        return self.selectedDate
    }
}
