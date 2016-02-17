//
//  Neue Stadt.swift
//  NikosWetterApp
//
//  Created by Nikos Stivaktakis on 17.02.16.
//  Copyright © 2016 Nikolaos Stivaktakis. All rights reserved.
//

import UIKit

protocol NeueStadtProtocol{
    func Datenubertragung(Ortname : String)
}

class NeueStadt: UIViewController {
    
    @IBOutlet weak var StadtnameTF: UITextField!
    var delegate = ViewController()
    var NeuerOrtname = "Kassel"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func TFEnterPressed(sender: AnyObject) {
        NeuerOrtname = StadtnameTF.text!
        delegate.Datenubertragung(NeuerOrtname)
    }
    
    @IBAction func StandortButtonPressed(sender: AnyObject) {
        // ToDO: Koordinaten holen Und Ortnamen setzen
        
        delegate.Datenubertragung(NeuerOrtname)
    }
    

}