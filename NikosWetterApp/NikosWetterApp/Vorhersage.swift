//
//  Vorhersage.swift
//  NikosWetterApp
//
//  Created by Nikos Stivaktakis on 22.02.16.
//  Copyright © 2016 Nikolaos Stivaktakis. All rights reserved.
//

import UIKit

class Vorhersage: UIViewController {
    
    @IBOutlet weak var TitelLabel: UILabel!
    @IBOutlet weak var VorhersageTextView: UITextView!
    @IBOutlet weak var Tag1Label: UILabel!
    @IBOutlet weak var Tag2Label: UILabel!
    @IBOutlet weak var Tag3Label: UILabel!
    @IBOutlet weak var Tag4Label: UILabel!
    @IBOutlet weak var Tag5Label: UILabel!
    @IBOutlet weak var Tag1Vor: UIImageView!
    @IBOutlet weak var Tag1Nach: UIImageView!
    @IBOutlet weak var Tag2Vor: UIImageView!
    @IBOutlet weak var Tag2Nach: UIImageView!
    @IBOutlet weak var Tag3Vor: UIImageView!
    @IBOutlet weak var Tag3Nach: UIImageView!
    @IBOutlet weak var Tag4Vor: UIImageView!
    @IBOutlet weak var Tag4Nach: UIImageView!
    @IBOutlet weak var Tag5Vor: UIImageView!
    
    
    
    var Koordilon = 0.0
    var Koordilat = 0.0
    var delegate = ViewController()
    var Ortname = ""
    
    var Status1Vor = ""
    var Status1Nach = ""
    var Status2Vor = ""
    var Status2Nach = ""
    var Status3Vor = ""
    var Status3Nach = ""
    var Status4Vor = ""
    var Status4Nach = ""
    var Status5Vor = ""
    var Status5Nach = ""
    
    var Temp1Vor = 0.0
    var Temp1Nach = 0.0
    var Temp2Vor = 0.0
    var Temp2Nach = 0.0
    var Temp3Vor = 0.0
    var Temp3Nach = 0.0
    var Temp4Vor = 0.0
    var Temp4Nach = 0.0
    var Temp5Vor = 0.0
    var Temp5Nach = 0.0

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TitelLabel.text = "Wettervorhersage " + Ortname
        datenladen()
    }
    
    func datenladen(){
        
        //Vom Internet laden (per URL)(Internetaktion definieren)
        let Koordinatenstring = "lat=" + String(Koordilat) + "&lon=" + String(Koordilon)
        let APIDatenURL = NSURL(string: "http://api.openweathermap.org/data/2.5/forecast?" +  (Koordinatenstring) + "&appid=44db6a862fba0b067b1930da0d769e98")
        let session = NSURLSession.sharedSession()
        let request = NSURLRequest(URL: APIDatenURL!)
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                print(error)
            } else {
                
                do{
                    if data != nil{
                        //Daten Auswerten
                        
                        let result =  (try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary)?.valueForKey("list") as! NSArray
                        
                        
                        
                        let date = NSDate(timeIntervalSince1970: result[0].valueForKey("dt") as! Double)

                        
                        let calendar = NSCalendar.currentCalendar()
                        let comp = calendar.components([.Hour, .Minute], fromDate: date)
                        let hour = comp.hour
                        
                        print(hour)
                        
                        var a = 0
                        
                        if hour == 1{
                            a = 3
                        }else if hour == 4{
                            a = 2
                        }else if hour == 7{
                            a = 1
                        }else if hour == 10{
                            a = 0
                        }else if hour == 13{
                            a = 7
                        }else if hour == 16{
                            a = 6
                        }else if hour == 19{
                            a = 5
                        }else if hour == 22{
                            a = 4
                        }
                        
                        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!

                        
                        // TAG 1
                        
                        
                        let DatenTag1V = result[a] as! NSDictionary
                        let date1V = NSDate(timeIntervalSince1970: DatenTag1V.valueForKey("dt") as! Double)
                        
                        let compo = myCalendar.components(.Weekday, fromDate: date1V)
                        self.Tag1Label.text = self.getrightwekkday(compo.weekday)
                        
                        for c in DatenTag1V.valueForKey("weather") as! NSArray{
                            self.Status1Vor =  c.valueForKey("main") as! String
                        }
                        
                        
                        let q  = DatenTag1V.valueForKey("main") as! NSDictionary
                        self.Temp1Vor = (q.valueForKey("temp") as! Double) - 273.15
                        
                        let DatenTag1N = result[a + 2] as! NSDictionary
                        
                        for cd in DatenTag1N.valueForKey("weather") as! NSArray{
                            self.Status1Nach =  cd.valueForKey("main") as! String
                        }
                        self.Temp1Nach = ((DatenTag1V.valueForKey("main") as! NSDictionary).valueForKey("temp") as! Double) - 273.15

                        
                        
                        
                        //TAG 2
                        
                        
                        
                        let DatenTag2V = result[a + 8] as! NSDictionary
                        let date2V = NSDate(timeIntervalSince1970: DatenTag2V.valueForKey("dt") as! Double)
                        
                        self.Tag2Label.text = self.getrightwekkday(myCalendar.components(.Weekday, fromDate: date2V).weekday)
                        
                        for c in DatenTag2V.valueForKey("weather") as! NSArray{
                            self.Status2Vor =  c.valueForKey("main") as! String
                        }
                        
                        
                        self.Temp2Vor = (((DatenTag2V.valueForKey("main") as! NSDictionary).valueForKey("temp")) as! Double) - 273.15
                        
                        let DatenTag2N = result[a + 10] as! NSDictionary
                        
                        for cd in DatenTag2N.valueForKey("weather") as! NSArray{
                            self.Status2Nach =  cd.valueForKey("main") as! String
                        }
                        self.Temp2Nach = ((DatenTag2V.valueForKey("main") as! NSDictionary).valueForKey("temp") as! Double) - 273.15
                        
                        
                        
                        // TAG 3
                        
                        
                        
                        let DatenTag3V = result[a + 16] as! NSDictionary
                        let date3V = NSDate(timeIntervalSince1970: DatenTag3V.valueForKey("dt") as! Double)
                        
                        self.Tag3Label.text = self.getrightwekkday(myCalendar.components(.Weekday, fromDate: date3V).weekday)
                        
                        for c in DatenTag3V.valueForKey("weather") as! NSArray{
                            self.Status3Vor =  c.valueForKey("main") as! String
                        }
                        
                        
                        self.Temp3Vor = (((DatenTag3V.valueForKey("main") as! NSDictionary).valueForKey("temp")) as! Double) - 273.15
                        
                        let DatenTag3N = result[a + 18] as! NSDictionary
                        
                        for cd in DatenTag3N.valueForKey("weather") as! NSArray{
                            self.Status3Nach =  cd.valueForKey("main") as! String
                        }
                        self.Temp3Nach = ((DatenTag3V.valueForKey("main") as! NSDictionary).valueForKey("temp") as! Double) - 273.15

                        
                        
                        //TAG 4
                        
                        
                        let DatenTag4V = result[a + 24] as! NSDictionary
                        let date4V = NSDate(timeIntervalSince1970: DatenTag4V.valueForKey("dt") as! Double)
                        
                        self.Tag4Label.text = self.getrightwekkday(myCalendar.components(.Weekday, fromDate: date4V).weekday)
                        
                        for c in DatenTag4V.valueForKey("weather") as! NSArray{
                            self.Status4Vor =  c.valueForKey("main") as! String
                        }
                        
                        
                        self.Temp4Vor = (((DatenTag4V.valueForKey("main") as! NSDictionary).valueForKey("temp")) as! Double) - 273.15
                        
                        let DatenTag4N = result[a + 26] as! NSDictionary
                        
                        for cd in DatenTag4N.valueForKey("weather") as! NSArray{
                            self.Status4Nach =  cd.valueForKey("main") as! String
                        }
                        self.Temp4Nach = ((DatenTag4V.valueForKey("main") as! NSDictionary).valueForKey("temp") as! Double) - 273.15

                        
                        // TAG 5
                        
//                        let DatenTag5V = result[a + 32] as! NSDictionary
//                        let date5V = NSDate(timeIntervalSince1970: DatenTag5V.valueForKey("dt") as! Double)
//                        
//                        self.Tag5Label.text = self.getrightwekkday(myCalendar.components(.Weekday, fromDate: date5V).weekday)
//                        
//                        for c in DatenTag5V.valueForKey("weather") as! NSArray{
//                            self.Status5Vor =  c.valueForKey("main") as! String
//                        }
//                        
//                        
//                        self.Temp5Vor = (((DatenTag5V.valueForKey("main") as! NSDictionary).valueForKey("temp")) as! Double) - 273.15
                        
//                        let DatenTag5N = result[a + 34] as! NSDictionary
//                        
//                        for cd in DatenTag5N.valueForKey("weather") as! NSArray{
//                            self.Status5Nach =  cd.valueForKey("main") as! String
//                        }
//                        self.Temp5Nach = ((DatenTag5V.valueForKey("main") as! NSDictionary).valueForKey("temp") as! Double) - 273.15

                        
                        
                        
                        // Fehler mint main_Threat beheben
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                            // do some task
                            dispatch_async(dispatch_get_main_queue(), {
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
    
    
    //}
    func getrightwekkday(number: Int) ->String{
        if number == 1{
            return "Sonntag"
        }else if number == 2{
            return "Montag"
        }else if number == 3{
            return "Dienstag"
        }else if number == 4{
            return "Mittwoch"
        }else if number == 5{
            return "Donnerstag"
        }else if number == 6{
            return "Freitag"
        }else if number == 7{
            return "Samstag"
        }else{
            return "error"
        }
}
    
    func getRightImage(zutesten : String) ->[String]{
        if zutesten == "Clear" {
            return ["sunny","ClearBG"]
        }else if zutesten == "Clouds"{
            return ["cloudy","Cloud_Background"]
        }else if zutesten == "Rain"{
            return ["rainy","Rainy_Background"]
        }else if zutesten == "Snow"{
            return ["Snow","Snow_Background"]
        }else if zutesten == "Fog"{
            return ["foggy","FogBG"]
        }else{
            return ["",""]
        }
    }

    func DatenAnzeigen(){
        
        
        
        let numberformatter = NSNumberFormatter()
        numberformatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        numberformatter.maximumFractionDigits = 2
        let dateformatter = NSDateFormatter()
        dateformatter.setLocalizedDateFormatFromTemplate("HH:mm")
        // Icons
        Tag1Vor.image = UIImage(named: getRightImage(Status1Vor)[0])
        Tag1Nach.image = UIImage(named: getRightImage(Status1Nach)[0])
        Tag2Vor.image = UIImage(named: getRightImage(Status2Vor)[0])
        Tag2Nach.image = UIImage(named: getRightImage(Status2Nach)[0])
        Tag3Vor.image = UIImage(named: getRightImage(Status3Vor)[0])
        Tag3Nach.image = UIImage(named: getRightImage(Status3Nach)[0])
        Tag4Vor.image = UIImage(named: getRightImage(Status4Vor)[0])
        Tag4Nach.image = UIImage(named: getRightImage(Status4Nach)[0])

        
        //Status & Temperatur
        let Teil1 = "\n\n\nVormittag\nWetter: " + String(Status1Vor) + "\nTemperatur: "
        let Teil2 = numberformatter.stringFromNumber(Temp1Vor)! + " °C\n\nNachmittag\nWetter: "
        let Teil3 =  String(Status1Nach) + "\nTemperatur: " + numberformatter.stringFromNumber(Temp1Nach)! + "°C"
        let Teil4 = "\n\n\n\nVormittag\nWetter: " + String(Status2Vor) + "\nTemperatur: " + numberformatter.stringFromNumber(Temp2Vor)!
        let Teil5 = " °C\n\nNachmittag\nWetter: " + String(Status2Nach) + "\nTemperatur: "
        let Teil6 = numberformatter.stringFromNumber(Temp2Nach)! + "°C" + "\n\n\n\nVormittag\nWetter: "
        let Teil7 = String(Status3Vor) + "\nTemperatur: " + numberformatter.stringFromNumber(Temp3Vor)! + "°C"
        let Teil8 = "\n\nNachmittag\nWetter: " + String(Status3Nach) + "\nTemperatur: " + numberformatter.stringFromNumber(Temp3Nach)! + "°C"
        let Teil9 = "\n\n\n\nVormittag\nWetter: " + String(Status4Vor) + "\nTemperatur: " + numberformatter.stringFromNumber(Temp4Vor)!
        let Teil10 = " °C\n\nNachmittag\nWetter: " + String(Status4Nach) + "\nTemperatur: " + numberformatter.stringFromNumber(Temp4Nach)! + "°C"
        
        VorhersageTextView.text = Teil1 + Teil2 + Teil3 + Teil4 + Teil5 + Teil6 + Teil7 + Teil8 + Teil9 + Teil10
    }
    
    @IBAction func BackButtonPressed(sender: AnyObject) {
        delegate.navigationController?.popToRootViewControllerAnimated(true)
        dismissViewControllerAnimated(true, completion: nil)
    }
}
