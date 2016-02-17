//
//  WetterDatenPaket.swift
//  NikosWetterApp
//
//  Created by Nikolaos Stivaktakis on 15.02.16.
//  Copyright (c) 2016 Nikolaos Stivaktakis. All rights reserved.
//

import UIKit

class WetterDatenPaket {
   
    
    var Ort : String
    var Wetterstatus : String
    var Temperatur : String
    var Koordinaten : [Int]
    var Luftdruck : Int
    var Sonnenaufgang : NSDate
    var Sonnenuntergang : NSDate
    var Windgeschwindigkeit : Int
    
    init(IOrt : String, IWetterStatus : String, ITemperatur : String, IKoordinaten: [Int], ILuftdruck : Int, ISonnenaufgang : NSDate, ISonnenuntergang : NSDate, IWindgeschwindigkeit : Int) {
        
        Ort = IOrt
        Temperatur = ITemperatur
        Koordinaten = IKoordinaten
        Wetterstatus = IWetterStatus
        Luftdruck = ILuftdruck
        Sonnenaufgang = ISonnenaufgang
        Sonnenuntergang = ISonnenuntergang
        Windgeschwindigkeit = IWindgeschwindigkeit
        
    }
    
}
