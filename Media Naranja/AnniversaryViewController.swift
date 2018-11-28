//
//  AnniversaryViewController.swift
//  Practica3
//
//  Created by g836 DIT UPM on 23/10/18.
//  Copyright © 2018 g836 DIT UPM. All rights reserved.
//

import UIKit

class AnniversaryViewController: UIViewController {

    @IBOutlet weak var anniversaryPicker: UIDatePicker!
    
    var anniversary : Date = Date()
    var cb: ((Date) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        anniversaryPicker.date = anniversary
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "sb ok"{
            if anniversaryPicker.date > Date() {
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
            
            anniversary = anniversaryPicker.date
            
            cb?(anniversaryPicker.date)
            
        }else if segue.identifier == "sb cancel"{
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
