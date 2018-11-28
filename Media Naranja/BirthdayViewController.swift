//
//  BirthdayViewController.swift
//  Practica3
//
//  Created by g836 DIT UPM on 23/10/18.
//  Copyright © 2018 g836 DIT UPM. All rights reserved.
//

import UIKit

class BirthdayViewController: UIViewController {
   
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    
    
    var birthday: Date = Date()
    
    var cb: ((Date) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthdayPicker.date = birthday
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "sb ok"{
            if birthdayPicker.date > Date() {
                let alert = UIAlertController(title: "ERROR",
                                              message: "Get off the Delorian",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "ok",
                                              style: .default))
                present(alert, animated: true)
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sb ok"{
            
            birthday = birthdayPicker.date
            
            cb?(birthdayPicker.date)
            
        }else if segue.identifier == "sb cancel"{
            
        }
        
    }
    
}

