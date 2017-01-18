//
//  PINViewController.swift
//  Simba
//
//  Created by Infinum on 12/01/17.
//  Copyright © 2017 Infinum. All rights reserved.
//

import UIKit

class PINViewController: UIViewController {

    @IBOutlet weak var PINtext: UITextField!
    @IBOutlet weak var PINretext: UITextField!
    
    @IBAction func SendPIN(_ sender: UIButton) {
        
        if (PINtext.text?.isEmpty ?? true || PINretext.text?.isEmpty ?? true){
            
            // Empty form alert
        
            
            
            return
            
        }
        else if(PINtext.text! != PINretext.text!) {
        
            // PINs dont match alert
            
            return
        }
        else {
            
            // Store data
            
            PIN = PINtext.text!
            
            // Perform segue
            
            performSegue(withIdentifier: "PINSegue", sender: self)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
