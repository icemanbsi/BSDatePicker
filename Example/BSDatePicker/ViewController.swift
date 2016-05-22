//
//  ViewController.swift
//  BSDatePicker
//
//  Created by Bobby Stenly on 05/22/2016.
//  Copyright (c) 2016 Bobby Stenly. All rights reserved.
//

import UIKit
import BSDatePicker

class ViewController: UIViewController {

    @IBOutlet weak var bsdDefault: BSDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.bsdDefault.viewController = self
        self.bsdDefault.defaultTitle = "Birthday"
        self.bsdDefault.title = "Birthday"
        self.bsdDefault.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

