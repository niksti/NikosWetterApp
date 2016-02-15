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
    
    init(IOrt : String, IWetterStatus : String, ITemperatur : String, IKoordinaten: [Int]) {
        
        Ort = IOrt
        Temperatur = ITemperatur
        Koordinaten = IKoordinaten
        Wetterstatus = IWetterStatus
        
    }
    
}
