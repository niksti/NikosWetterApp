//
//  SideTableView.swift
//  NikosWetterApp
//
//  Created by Nikos Stivaktakis on 24.02.16.
//  Copyright © 2016 Nikolaos Stivaktakis. All rights reserved.
//

import UIKit
import AMSlideMenu
import SwiftHEXColors

class SideTableView: AMSlideMenuLeftTableViewController {
    
    @IBOutlet weak var NavigationBar: UINavigationBar!
    @IBOutlet weak var NavigationItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame.origin = CGPoint(x: 0, y: 40)
        view.backgroundColor = UIColor(hexString: "#383838")
        tableView.separatorColor = UIColor.clearColor()
        NavigationBar.tintColor = UIColor.whiteColor()
        NavigationBar.barTintColor = UIColor(hexString: "#383838")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        cell.textLabel!.text = (Orte[indexPath.row])
        cell.backgroundColor = UIColor(hexString: "#383838")
        cell.textLabel!.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Orte.count
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            
            Orte.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(Orte, forKey: "Ortname")
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "firstSegue"{
        let vc = (segue.destinationViewController as! UINavigationController).viewControllers[0] as! ViewController
            vc.TableView = self
        }
    }
}
