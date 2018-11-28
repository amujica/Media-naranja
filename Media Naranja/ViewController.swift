//
//  ViewController.swift
//  Practica3
//
//  Created by g836 DIT UPM on 23/10/18.
//  Copyright © 2018 g836 DIT UPM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //datos del aniversario
    var yearLove: Int?
    var monthLove: Int?
    var dayLove: Int?
    //datos del cumpleaños
    var yearBirthdate: Int?
    var monthBirthday: Int?
    var dayBirthday: Int?
    
    //datos resultado
    var yearRes: Int?
    var monthRes: Int?
    var dayRes: Int?
    
    var yearFechaActual: Int?


    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var anniversaryLabel: UILabel!
    @IBOutlet weak var resultado: UILabel!
    
    var myBirthday: Date?
    var myAnniversary: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBL()
        updateAL()
    }
    
    func updateBL(){
        
        if let bd = myBirthday{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            
            // US English Locale (en_US)
            dateFormatter.locale = Locale(identifier: "es_ES")
            
            let texto = dateFormatter.string(from: bd)
            
            birthdayLabel.text = "I was born on  \(texto)"
            
            dateFormatter.dateFormat = "yyyy"
            yearBirthdate = Int(dateFormatter.string(from: bd))
            dateFormatter.dateFormat = "MM"
            monthBirthday = Int(dateFormatter.string(from: bd))
            dateFormatter.dateFormat = "dd"
            dayBirthday = Int(dateFormatter.string(from: bd))
            
        } else {
            birthdayLabel.text = "I don´t know when I was born"
        }
    }
    func updateAL(){
        if let an = myAnniversary{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            
            // US English Locale (en_US)
            dateFormatter.locale = Locale(identifier: "es_ES")
            
            let fecha = dateFormatter.string(from: an) // Jan 2, 2001
            
            anniversaryLabel.text = "I fell in love on  \(fecha)"
            
            dateFormatter.dateFormat = "yyyy"
            yearLove = Int(dateFormatter.string(from: an))
            dateFormatter.dateFormat = "MM"
            monthLove = Int(dateFormatter.string(from: an))
            dateFormatter.dateFormat = "dd"
            dayLove = Int(dateFormatter.string(from: an))
            
        } else {
            anniversaryLabel.text = "Sorry, but you don´t have luck in love yet"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Select Birthday"{
            if let bvc = segue.destination as? BirthdayViewController{
                
                if let b = myBirthday{
                    bvc.birthday = b
                }
                
                bvc.cb = { (date:Date) -> () in
                    self.myBirthday = date
                    self.updateBL()
                }
            }
        } else if segue.identifier == "Select Anniversary"{
            
            if let avc = segue.destination as? AnniversaryViewController{
                
                if let a = myAnniversary{
                    avc.anniversary = a
                }
                avc.cb = { (date: Date) -> () in
                    self.myAnniversary = date
                    self.updateAL()
                    
                }
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func firstPage(_ segue: UIStoryboardSegue){
        if segue.identifier == "Selected Birthday"{
            if segue.identifier == "sb ok"{
                if let bvc = segue.source as? BirthdayViewController{
                    myBirthday = bvc.birthday
                    updateBL()
                }
                
            }else if segue.identifier == "sb cancel"{ }
            
        }else if segue.identifier == "Selected Anniversary"{
            if segue.identifier == "sb ok"{
                if let avc = segue.source as? AnniversaryViewController{
                    myAnniversary = avc.anniversary
                    updateAL()
                }
                
            }else if segue.identifier == "sb cancel"{ }
        }
    }
    
    @IBAction func calcular(_ sender: UIButton) {
         if(myBirthday != nil && myAnniversary != nil){
            if( (yearBirthdate! > yearLove!) ||
                (monthBirthday! > monthLove! && yearBirthdate! == yearLove!) ||
                (dayBirthday! > dayLove! && monthBirthday! == monthLove! && yearBirthdate! == yearLove!)){
                let alert = UIAlertController(title: "ERROR",
                                              message: "You cant fall in love before you born",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "ok",
                                              style: .default))
                present(alert, animated: true)
                resultado.text = "It´s impossible! "
                
            }else{
                
                let calendar = Calendar.current
                
                let birthDate = calendar.startOfDay(for: myBirthday!)
                let anniversaryDate = calendar.startOfDay(for: myAnniversary!)
                
                let days = Set<Calendar.Component>([.day])
                
                let numberOfDays = calendar.dateComponents(days, from: birthDate, to: anniversaryDate)
                let dateRes = calendar.date(byAdding: .day, value: numberOfDays.day!, to:myAnniversary!)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-YYYY"
                
                resultado.text = "Your midd orange day will be on " + dateFormatter.string(from: dateRes!)
            }
        }
        else {
            let alert = UIAlertController(title: "ERROR",
                                          message: "Introduce your dates",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok",
                                          style: .default))
            present(alert, animated: true)
        }
        
       
    }
    
}

