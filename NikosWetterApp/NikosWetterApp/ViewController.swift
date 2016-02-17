//
//  ViewController.swift
//  NikosWetterApp
//
//  Created by Nikolaos Stivaktakis on 15.02.16.
//  Copyright (c) 2016 Nikolaos Stivaktakis. All rights reserved.
//

import UIKit

//NSUrlSession -> get
//SwiftyJSON

class ViewController: UIViewController, NeueStadtProtocol {

    @IBOutlet weak var OrtLabel: UILabel!
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var TemperaturLabel: UILabel!
    @IBOutlet weak var IconImageView: UIImageView!
    @IBOutlet weak var NeuerOrtButton: UIButton!
    @IBOutlet weak var VorherNachherButton: UIButton!
    @IBOutlet weak var BurgerMenuButtton: UIButton!
    @IBOutlet weak var ZusaetzlichesTextView: UITextView!
    @IBOutlet weak var BackgroundImageView: UIImageView!
    var Ortname = "Darmstadt"
    var Wetterstatus = "Clouds"
    var Temperatur =  5.1
    var Koordinaten = [3,3]
    var Luftdruck = 1000
    var Sonnenaufgang = NSDate(timeIntervalSince1970: 10000000)
    var Sonnenuntergang = NSDate(timeIntervalSince1970: 10000000)
    var Windgeschwindigkeit = 10.5
    var APIDatenURL = NSURL()
    var BackGroundImageName = ""
    var IconImageName = ""
    var daten : WetterDatenPaket?
    
//json["weather"]["description"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatenLaden()
       // DatenAnzeigen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

      
      func DatenLaden() {
        APIDatenURL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(Ortname),uk&appid=44db6a862fba0b067b1930da0d769e98")!
        var datenanzeigen = false
        var session = NSURLSession.sharedSession()
        var request = NSURLRequest(URL: APIDatenURL)
        var task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                print(error)
            } else {
                
            do{
                   if data != nil{
                        let result =  try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
                        print(result?.valueForKey("weather"))
                    for j in result?.valueForKey("weather") as! NSArray{
                       
                        self.Wetterstatus =  j.valueForKey("main") as! String
                        
                    }
                    let a  = result?.valueForKey("main") as! NSDictionary
                    self.Temperatur = (a.valueForKey("temp") as! Double) - 273.15
                    
                    
                    let b  = result?.valueForKey("sys") as! NSDictionary
                    self.Sonnenaufgang = NSDate(timeIntervalSince1970: (b.valueForKey("sunrise") as! NSTimeInterval))
                    self.Sonnenuntergang = NSDate(timeIntervalSince1970: (b.valueForKey("sunset") as! NSTimeInterval))
                    
                    let c = result?.valueForKey("wind") as! NSDictionary
                    self.Windgeschwindigkeit = (c.valueForKey("speed") as! Double) * 3.6
                    
                    //self.Ortname = result?.valueForKey("name") as! String
                    
                    
                    
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
        task.resume()
        
                    }
    
    func getRightImage() {
        let zutesten = Wetterstatus
        if zutesten == "Clear" {
           IconImageName =  "sunny"
            BackGroundImageName = "Clear_Background"
            
            
        }else if zutesten == "Clouds"{
            IconImageName = "cloudy"
            BackGroundImageName = "Cloud_Background"
        }else if zutesten == "Rain"{
            IconImageName = "rainy"
            BackGroundImageName = "Rainy_Background"
        }
        
    }
    
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
        BackgroundImageView.image = UIImage(named: "\(BackGroundImageName)")
        ZusaetzlichesTextView.text = "sunrise: " + dateformatter.stringFromDate(Sonnenaufgang) + "\n sunset: " + dateformatter.stringFromDate(Sonnenuntergang) + "\n wind speed:" + numberformatter.stringFromNumber(Windgeschwindigkeit)! + "km/h"
        }
    
    func Datenubertragung(NeuerOrtname: String) {
        Ortname = NeuerOrtname
        self.navigationController?.popToRootViewControllerAnimated(true)
        DatenLaden()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ZuNeueStadt"{
            let vc = segue.destinationViewController as! NeueStadt
            vc.delegate = self
        }
    }
    
}

