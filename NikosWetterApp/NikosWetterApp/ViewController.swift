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
        let Wetterdaten = WetterDatenPaket(IOrt: "Darmstadt", IWetterStatus: "Clouds", ITemperatur: "4" , IKoordinaten: [50,50])
        
        daten = Wetterdaten
    }
    
    func getRightImage() {
        let zutesten = daten?.Wetterstatus
        if zutesten == "Clear" {
           IconImageName =  "sunny.png"
            BackGroundImageName = "Clear_Background.jpg"
        }else if zutesten == "Clouds"{
            IconImageName = "cloudy.png"
            BackGroundImageName = "Cloudy_Background.jpg"
        }else if zutesten == "Rain"{
            IconImageName = "rainy.png"
            BackGroundImageName = "Rain_Background.jpg"
        }
        
    }
    
    func DatenAnzeigen(){
        if daten != nil {
        
        OrtLabel.text = daten?.Ort
        StatusLabel.text = daten?.Wetterstatus
        TemperaturLabel.text = (daten?.Temperatur)! + " °C"
        IconImageView.image = UIImage(named: "\(IconImageName)")
        BackgroundImageView.image = UIImage(named: "\(BackGroundImageName)")
        ZusaetzlichesTextView.text = "Druck: 1000 \n SonnenAufgang: 7:20\n SonnenUntergang: 20:20 \n Windstärke: 10 km/h"
        }else{
            OrtLabel.text = "Fehler Beim Laden"
        }
            
    }
    
}

