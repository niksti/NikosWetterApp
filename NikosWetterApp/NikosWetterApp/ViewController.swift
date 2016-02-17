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
    var Ortname = "Darmstadt"
    var Wetterstatus = "Clouds"
    var Temperatur =  "5 "
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
        getRightImage()
        DatenAnzeigen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func DatenLaden() {
        APIDatenURL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(Ortname),uk&appid=44db6a862fba0b067b1930da0d769e98")!
        var session = NSURLSession.sharedSession()
        var request = NSURLRequest(URL: APIDatenURL)
        var task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                print(error)
            } else {
                
                do{
                    if data != nil{
                        var result =  try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String : AnyObject]
                    
                        var newdict  = result!["weather"]
                        /*var Temperatur =  "5 "
                        var Koordinaten = [3,3]
                        var Luftdruck = 1000
                        var Sonnenaufgang = NSDate(timeIntervalSince1970: 10000000)
                        var Sonnenuntergang = NSDate(timeIntervalSince1970: 10000000)
                        var Windgeschwindigkeit = 10*/

                        
                        print(result!)
                    }
                }
                catch{
                    print(error)
                    
                }
                
                
            }
        }
        task.resume()
        
        let wetterdaten = WetterDatenPaket(IOrt: Ortname, IWetterStatus: Wetterstatus, ITemperatur: Temperatur, IKoordinaten: Koordinaten, ILuftdruck: Luftdruck, ISonnenaufgang: Sonnenaufgang, ISonnenuntergang: Sonnenuntergang , IWindgeschwindigkeit: Windgeschwindigkeit)
        daten = wetterdaten
    }
    
    func getRightImage() {
        let zutesten = daten?.Wetterstatus
        if zutesten == "Clear" {
           IconImageName =  "sunny"
            BackGroundImageName = "Clear_Background"
            
        }else if zutesten == "Clouds"{
            IconImageName = "cloudy"
            BackGroundImageName = "Cloud_Background"
        }else if zutesten == "Rain"{
            IconImageName = "rainy"
            BackGroundImageName = "Rain_Background"
        }
        
    }
    
    func DatenAnzeigen(){
        if daten != nil {
        
        OrtLabel.text = daten?.Ort
        StatusLabel.text = daten?.Wetterstatus
        TemperaturLabel.text = (daten?.Temperatur)! + " °C"
        IconImageView.image = UIImage(named: "\(IconImageName)")
        BackgroundImageView.image = UIImage(named: "\(BackGroundImageName)")
        ZusaetzlichesTextView.text = "pressure: 1000 \n sunrise: 7:20\n sunset: 20:20 \n wind speed: 10 km/h"
        }else{
            OrtLabel.text = "Fehler Beim Laden"
        }
            
    }
    
}

