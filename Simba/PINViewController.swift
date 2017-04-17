//
//  PINViewController.swift
//  Simba
//
//  Created by Infinum on 12/01/17.
//  Copyright © 2017 Infinum. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PINViewController: UIViewController {
    
    //Variable passed through ID segue
    
    var user: String?
    
    //Alamofire completion handler functions
    //PIN POSTING FUNCTIONS
    
    func setPIN(completionHandler: @escaping (String, Error?) -> ()){
        let User = user
        let PIN = PINtext.text!
        makeCall(User: User!,PIN: PIN, completionHandler: completionHandler)
    }
    
    func makeCall (User: String, PIN: String, completionHandler: @escaping (String, Error?) -> ()){
        
        let callURL = URL + "PIN"
        
        let parameters: Parameters = ["user": user!, "PIN": PIN]
        
        //POST METHOD
        
        Alamofire.request(callURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseString { response in
        
            switch response.result{
            case .success(let value):
                let result = response.result.value! // result of response serialization
            
                print(result)
                print("Communication successful!")
                completionHandler(value, nil)
            case .failure(let Error):
                print(Error)
                print("Communication failed!")
                completionHandler(Error as! String, nil)
            }
        }
        
    }

    //OUTLETS
    
    
    @IBOutlet weak var PINtext: UITextField!
    @IBOutlet weak var PINretext: UITextField!
    
    @IBAction func Home(_ sender: AnyObject) {
        
            performSegue(withIdentifier: "HomeScreenSegue", sender: self)
        
    }
    
    @IBAction func SendPIN(_ sender: UIButton) {
        
        if (PINtext.text?.isEmpty ?? true || PINretext.text?.isEmpty ?? true){
            
            // Empty form alert
            
            displayAlertMessage(userMessage: "Please fill both PIN fields")
            
            // Clearing text fields
            
            PINtext.text = nil
            PINretext.text = nil
            
            return
            
        }
        else if(PINtext.text! != PINretext.text!) {
        
            // PINs dont match alert
            
            displayAlertMessage(userMessage: "PINs dont match, please try again")
            
            // Clearing text fields 
            
            PINtext.text = nil
            PINretext.text = nil
            
            return
        }
        else if (PINtext.text!.characters.count != 4){
        
            // PINs need 4 nums
            
            displayAlertMessage(userMessage: "PIN has to contain 4 numbers")
            
            // Clearing text fields
            
            PINtext.text = nil
            PINretext.text = nil
        
        }
        else {
            
            // Store data
            
            //SENDING DATA TO WEB SERVER
            //POSTING PIN AND USER
            
            self.setPIN() { responseObject, error in
                
                print (responseObject)
                
                if (responseObject == "PIN Added") {
                    
                    // Perform segue
                    
                    self.performSegue(withIdentifier: "PINSegue", sender: self)
                    
                    let callURL = URL + "OTP/" + self.user!
                    
                    Alamofire.request(callURL).validate().responseJSON { response in
                        
                        switch response.result{
                        case .success(let value):
                            let json = JSON(value)
                            OTPlist = json
                            //Saving OTP list file
                            UserDefaults.standard.set(json, forKey: self.user!)
                            UserDefaults.standard.synchronize()
                            
                            print("JSON: \(json)")
                        case .failure(let error):
                            print(error)
                        }
                    }
                    
                    
                }
                else {
                    
                    // User not defined alert
                    
                    self.displayAlertMessage(userMessage: "PIN already set")
                    
                }
                
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
