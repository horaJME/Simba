//
//  CredentialsViewController.swift
//  Simba
//
//  Created by Infinum on 12/01/17.
//  Copyright © 2017 Infinum. All rights reserved.
//

import UIKit
import Alamofire

class CredentialsViewController: UIViewController {

    @IBOutlet weak var GivenIDText: UITextField!
    @IBAction func SendGivenID(_ sender: AnyObject) {
        
        // Check for empty fields
        
        if (GivenIDText.text?.isEmpty ?? true){
            
            // Empty form alert
            
            displayAlertMessage(userMessage: "Please insert given ID")
            
            return
            
        }
        
        Alamofire.request("http://192.168.5.10/my-rest-api/api/user/mh47330").responseString { response in
            
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            
            print(response.result.value)   // result of response serialization
 
            /*
             if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            */
        }

        
        if (DocList.contains(GivenIDText.text!)) {
        
            // Perform segue
            
             performSegue(withIdentifier: "GivenIDSegue", sender: self)
            
        }
        else {
            
            // User not defined alert
            
             displayAlertMessage(userMessage: "ID not defined in system")
            
        }

    }
    
    func displayAlertMessage (userMessage: String) {
    
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Understood", style: .default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
    
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
