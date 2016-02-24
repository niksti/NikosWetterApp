//
//  MainVC.swift
//  NikosWetterApp
//
//  Created by Nikos Stivaktakis on 24.02.16.
//  Copyright © 2016 Nikolaos Stivaktakis. All rights reserved.
//

import UIKit
import AMSlideMenu

class MainVC : AMSlideMenuMainViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func segueIdentifierForIndexPathInLeftMenu(indexPath: NSIndexPath!) -> String! {
        return "firstSegue"
    }
    override func configureLeftMenuButton(button: UIButton!) {
        var frame = button.frame
        frame.origin = CGPoint(x: 20, y: 20)
        frame.size = CGSize(width: 40, height: 40)
        button.frame = frame
        
        button.setImage(UIImage(named: "menu"), forState: UIControlState.Normal)
        
    }
    override func deepnessForLeftMenu() -> Bool {
        return false
    }
}
