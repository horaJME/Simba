//
//  AuthViewController.swift
//  Simba
//
//  Created by Infinum on 12/01/17.
//  Copyright © 2017 Infinum. All rights reserved.
//

import UIKit

var PIN2 = ""

class AuthViewController: UIViewController {

    @IBOutlet weak var PINText: UITextField!
    
    @IBAction func SendPIN(_ sender: UIButton) {
        
        if (PINText.text?.isEmpty ?? true){
            
            // Empty form alert
            
            
            return
            
        }
        else {
            
            // Store data
            
            PIN2 = PINText.text!

            
            // Perform segue
            
            performSegue(withIdentifier: "SuccessSegue", sender: self)
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
