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
    
    func getUser(completionHandler: @escaping (String, Error?) -> ()){
        let User = GivenIDText.text!
        makeCall(User: User, completionHandler: completionHandler)
    }
    
    func makeCall (User: String, completionHandler: @escaping (String, Error?) -> ()){
        
        let URL = "http://192.168.5.10/my-rest-api/api/user/" + (User)
        
        Alamofire.request(URL).validate().responseString { response in
            
            switch response.result{
            case .success(let value):
                let result = response.result.value! // result of response serialization
                print(result)
                print("Communication Successful!")
                completionHandler(value, nil)
            case .failure(let Error):
                print(Error)
                completionHandler(Error as! String, nil)
            }
        }
    
    }
    
    
    

    @IBOutlet weak var GivenIDText: UITextField!
    @IBAction func SendGivenID(_ sender: AnyObject) {
        
        // Check for empty fields
        
        if (GivenIDText.text?.isEmpty ?? true){
            
            // Empty form alert
            
            displayAlertMessage(userMessage: "Please insert given ID")
            
            return
            
        }
        
       
        self.getUser() { responseObject, error in
        
            if (responseObject == "User exists") {
                
                // Perform segue
                
                self.performSegue(withIdentifier: "GivenIDSegue", sender: self)
                
            }
            else {
                
                // User not defined alert
                
                self.displayAlertMessage(userMessage: "ID not defined in system")
                
            }
            
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
