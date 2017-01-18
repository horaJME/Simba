//
//  CredentialsViewController.swift
//  Simba
//
//  Created by Infinum on 12/01/17.
//  Copyright © 2017 Infinum. All rights reserved.
//

import UIKit

class CredentialsViewController: UIViewController {

    @IBOutlet weak var GivenIDText: UITextField!
    @IBAction func SendGivenID(_ sender: AnyObject) {
        
        // Check for empty fields
        
        if (GivenIDText.text?.isEmpty ?? true){
            
            // Empty form alert
            
            
            return
            
        }
        else {
            
            // Store data
            
            ID = GivenIDText.text!
            
            // Perform segue
            
            performSegue(withIdentifier: "GivenIDSegue", sender: self)
            
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
