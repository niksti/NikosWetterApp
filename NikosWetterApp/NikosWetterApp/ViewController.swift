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
    var daten : WetterDatenPaket?
    
//json["weather"]["description"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatenLaden()
        DatenAnzeigen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func DatenLaden() {
        let Wetterdaten = WetterDatenPaket(IOrt: "Darmstadt", IWetterStatus: "Wolkig", ITemperatur: "4" , IKoordinaten: [50,50])
        
        daten = Wetterdaten
    }
    
    func DatenAnzeigen(){
        if daten != nil {
        
        OrtLabel.text = daten?.Ort
        StatusLabel.text = daten?.Wetterstatus
        TemperaturLabel.text = (daten?.Temperatur)! + " °C"
        }else{
            OrtLabel.text = "Fehler Beim Laden"
        }
            
    }
    
}

