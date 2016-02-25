 //
//  ViewController.swift
//  NikosWetterApp
//
//  Created by Nikolaos Stivaktakis on 15.02.16.
//  Copyright (c) 2016 Nikolaos Stivaktakis. All rights reserved.
//

import UIKit
import SwiftHEXColors



var Orte = [String]()
 var index = 0

class ViewController: UIViewController {

    
    // Variablen
    
    @IBOutlet weak var windspeedLB: UILabel!
    @IBOutlet weak var SunsetLB: UILabel!
    @IBOutlet weak var SunriseLB: UILabel!
    @IBOutlet weak var OrtLabel: UILabel!
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var TemperaturLabel: UILabel!
    @IBOutlet weak var IconImageView: UIImageView!
    @IBOutlet weak var VorherNachherButton: UIButton!
    @IBOutlet weak var ZusaetzlichesTextView: UITextView!
    @IBOutlet weak var BackgroundImageView: UIImageView!
    var TableView = SideTableView()
    var indexa = index
    var Ortname = ""
    var Wetterstatus = "Clouds"
    var Temperatur =  5.1
    var Luftdruck = 1000
    var Sonnenaufgang = NSDate(timeIntervalSince1970: 10000000)
    var Sonnenuntergang = NSDate(timeIntervalSince1970: 10000000)
    var Windgeschwindigkeit = 10.5
    var APIDatenURL = NSURL()
    var BackGroundImageName = ""
    var IconImageName = ""
    var Koordinatenname = ""
    var Koordilon = 0.0
    var Koordilat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.backgroundColor = UIColor(hexString: "#383838")
                if NSUserDefaults.standardUserDefaults().arrayForKey("Ortname") != nil{
        Orte = NSUserDefaults.standardUserDefaults().arrayForKey("Ortname") as! [String]
                    Ortname = Orte[indexa]
        }else{
            Ortname = "Darmstadt"
        }
       DatenLaden(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func DatenLaden(Art : Bool) {
        //Vom Internet laden (per URL)(Internetaktion definieren)
        if Art {
            Ortname = Ortname.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())!
            APIDatenURL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(Ortname),uk&appid=44db6a862fba0b067b1930da0d769e98")!

        }
        else if !Art{
            APIDatenURL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?" +  (Koordinatenname) + "&appid=44db6a862fba0b067b1930da0d769e98")!
        }
        let session = NSURLSession.sharedSession()
        let request = NSURLRequest(URL: APIDatenURL)
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                print(error)
            } else {
                self.OrtLabel.text = "Fehler beim verbinden"
                self.BackgroundImageView.image = UIImage(named: "ClearBG")
            do{
                   if data != nil{
                    //Daten Auswerten
                    if let result =  try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary{
                    for j in result.valueForKey("weather") as! NSArray{
                       
                        self.Wetterstatus =  j.valueForKey("main") as! String
                        
                    }
                    let a  = result.valueForKey("main") as! NSDictionary
                    self.Temperatur = (a.valueForKey("temp") as! Double) - 273.15
                    
                    
                    let b  = result.valueForKey("sys") as! NSDictionary
                    self.Sonnenaufgang = NSDate(timeIntervalSince1970: (b.valueForKey("sunrise") as! NSTimeInterval))
                    self.Sonnenuntergang = NSDate(timeIntervalSince1970: (b.valueForKey("sunset") as! NSTimeInterval))
                    
                    let c = result.valueForKey("wind") as! NSDictionary
                    self.Windgeschwindigkeit = (c.valueForKey("speed") as! Double) * 3.6
                    
                    if !Art{
                        self.Ortname = result.valueForKey("name") as! String
                    }else{
                        self.Ortname = self.Ortname.stringByRemovingPercentEncoding!
                    }
                    
                    let Koordinaten = result.valueForKey("coord") as! NSDictionary
                    self.Koordilon = Koordinaten.valueForKey("lon") as! Double
                    self.Koordilat = Koordinaten.valueForKey("lat") as! Double

                    }else{
                        print("error")
                    }
                    
                    // Fehler mint main_Threat beheben
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                            // do some task
                            dispatch_async(dispatch_get_main_queue(), {
                                self.getRightImage()
                                self.DatenAnzeigen()

                                });
                        });

                    }

                }
                catch{
                    print(error)
                    
                }

                
            }

        }
        // INternetAktion ausführen
        task.resume()

        
                    }
    
    @IBAction func ShareButtonPressed(sender: AnyObject) {
      let Imagetoshare = UIImage(named: BackGroundImageName)
        let Texttoshare = "Bin gerade in " +  Ortname + ". \nMeine Temperatur: " +  TemperaturLabel.text! + "\n"
        let activityVC = UIActivityViewController(activityItems: [Imagetoshare!, Texttoshare], applicationActivities: nil)
        
        self.presentViewController(activityVC, animated: true, completion: nil)
        
    }
    // richtiges ICon/Hintergrundbild anzeigen
    func getRightImage() {
        let zutesten = Wetterstatus
        if zutesten == "Clear" {
            IconImageName =  "sunny"
            BackGroundImageName = "ClearBG"
        }else if zutesten == "Clouds"{
            IconImageName = "cloudy"
            BackGroundImageName = "Cloud_Background"
        }else if zutesten == "Rain"{
            IconImageName = "rainy"
            BackGroundImageName = "Rainy_Background"
        }else if zutesten == "Snow"{
            IconImageName = "Snow"
            BackGroundImageName = "Snow_Background"
        }else if zutesten == "Fog"{
            IconImageName =  "foggy"
            BackGroundImageName = "FogBG"
        }

        
    }
    
        //geladene Daten anzeigen
    func DatenAnzeigen(){
        
        OrtLabel.text = Ortname
        StatusLabel.text = Wetterstatus
        let numberformatter = NSNumberFormatter()
        numberformatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        numberformatter.maximumFractionDigits = 2
        let dateformatter = NSDateFormatter()
        dateformatter.setLocalizedDateFormatFromTemplate("HH:mm")
        TemperaturLabel.text = numberformatter.stringFromNumber(Temperatur)! + " °C"
        IconImageView.image = UIImage(named: "\(IconImageName)")
        BackgroundImageView.image = UIImage(named: BackGroundImageName)
        SunriseLB.text = dateformatter.stringFromDate(Sonnenaufgang)
        SunsetLB.text =  dateformatter.stringFromDate(Sonnenuntergang)
        windspeedLB.text = numberformatter.stringFromNumber(Windgeschwindigkeit)! + " km/h"
        
        if Orte.indexOf(Ortname) == nil{
            Orte.append(Ortname)

        }
        self.TableView.tableView.reloadData()
        NSUserDefaults.standardUserDefaults().setObject(Orte, forKey: "Ortname")
        
    }
    
    //Für die Datenübertragung von NeueStadt.swift
    func Datenubertragung(NeuerOrtname: String, Art : Bool) {
        if Art{
            Ortname = NeuerOrtname
            DatenLaden(true)
        }else if Art == false{
         Koordinatenname = NeuerOrtname
            DatenLaden(false)
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ZuNeueStadt"{
            let vc = segue.destinationViewController as! NeueStadt
            vc.delegate = self
        }else if segue.identifier == "Vorhersage" {
            let vc = segue.destinationViewController as! Vorhersage
            
            vc.delegate = self
            vc.Koordilat = self.Koordilat
            vc.Koordilon = self.Koordilon
            vc.Ortname = self.Ortname
        }
    }
    
}

