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

class ViewController: UIViewController {

    @IBOutlet weak var OrtLabel: UILabel!
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var TemperaturLabel: UILabel!
    @IBOutlet weak var IconImageView: UIImageView!
    @IBOutlet weak var NeuerOrtButton: UIButton!
    @IBOutlet weak var VorherNachherButton: UIButton!
    @IBOutlet weak var BurgerMenuButtton: UIButton!
    @IBOutlet weak var ZusaetzlichesTextView: UITextView!
    @IBOutlet weak var BackgroundImageView: UIImageView!
    var Ortname = "Alaska"
    var Wetterstatus = "Clouds"
    var Temperatur =  5.1
    var Koordinaten = [3,3]
    var Luftdruck = 1000
    var Sonnenaufgang = NSDate(timeIntervalSince1970: 10000000)
    var Sonnenuntergang = NSDate(timeIntervalSince1970: 10000000)
    var Windgeschwindigkeit = 10
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
                        print (self.Wetterstatus)
                        
                    }
                    let a  = result?.valueForKey("main") as! NSDictionary
                    self.Temperatur = (a.valueForKey("temp") as! Double) - 273.15
                    
                    print(String(self.Temperatur))
                    
                    
                    
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
        
        //let wetterdaten = WetterDatenPaket(IOrt: Ortname, IWetterStatus: Wetterstatus, ITemperatur: Temperatur, IKoordinaten: Koordinaten, ILuftdruck: Luftdruck, ISonnenaufgang: Sonnenaufgang, ISonnenuntergang: Sonnenuntergang , IWindgeschwindigkeit: Windgeschwindigkeit)
        //daten = wetterdaten
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
        TemperaturLabel.text = numberformatter.stringFromNumber(Temperatur)! + " °C"
        IconImageView.image = UIImage(named: "\(IconImageName)")
        BackgroundImageView.image = UIImage(named: "\(BackGroundImageName)")
        ZusaetzlichesTextView.text = "pressure: 1000 \n sunrise: 7:20\n sunset: 20:20 \n wind speed: 10 km/h"
        }
            
    
    
}

