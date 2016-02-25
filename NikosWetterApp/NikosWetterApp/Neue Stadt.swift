//
//  Neue Stadt.swift
//  NikosWetterApp
//
//  Created by Nikos Stivaktakis on 17.02.16.
//  Copyright © 2016 Nikolaos Stivaktakis. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreLocation

//protocol NeueStadtProtocol{
//    func Datenubertragung(Ortname : String)
//}

class NeueStadt: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var StadtnameTF: UITextField!
    var delegate : ViewController = ViewController()
    var NeuerOrtname = "Kassel"
    var locationmanager = CLLocationManager()
    var currentlocation = CLLocation()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationmanager = CLLocationManager()
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.requestAlwaysAuthorization()
        locationmanager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationmanager.startUpdatingLocation()
    }
    //Per Text eingegebener Stadtname auswerten
    @IBAction func TFEnterPressed(sender: AnyObject) {
        NeuerOrtname = StadtnameTF.text!
        delegate.Datenubertragung(NeuerOrtname, Art: true)

        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    // per Standort Stadt aussuchen
    @IBAction func StandortButtonPressed(sender: AnyObject)  {
        // ToDO: Koordinaten holen Und Ortnamen setzen
        //currentlocation = locationmanager.location!
        let Koordinatenstring = "lat=" + String(currentlocation.coordinate.latitude) + "&lon=" + String(currentlocation.coordinate.longitude)
        delegate.Datenubertragung(Koordinatenstring, Art: false)
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)


    }
    
    @IBAction func backpressed(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)

    }
    
    
        func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            currentlocation = locations [0]
    }
}