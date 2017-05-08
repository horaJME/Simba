//
//  AuthPINController.swift
//  Simba
//
//  Created by Infinum on 03/05/17.
//  Copyright © 2017 Infinum. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AuthPINController: UIViewController {
    
    var OTP: String?
    var sent: String?
    
    @IBOutlet weak var PINText: AllowedCharsTextField!
    @IBAction func SendPIN(_ sender: AnyObject) {
        
        let user: String
        let counter: Int
        
        if (PINText.text?.isEmpty ?? true){
            
            // Empty form alert
            
            displayAlertMessage(userMessage: "Please enter PIN")
            
            return
            
        } else if let value = UserDefaults.standard.string(forKey: sent!){
            
            
            // Read into OTP list file
            var file = JSON.init(parseJSON: value)
            user = file["user"].stringValue
            counter = file["counter"].intValue
            print(user)
            print(counter)
            
            //Checking if PIN is correct
            
            if(PINText.text! == file["PIN"].stringValue){
            
                //Preparing call
                OTP = file["OTPlist"][counter]["OTP"].string
                let callURL = URL + "auth"
                let parameters: Parameters = ["user": user, "OTP": OTP!]
                print(parameters)
                print(file.rawString())
                Alamofire.request(callURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
                    
                    switch response.result{
                    case .success(let value):
                        let json = JSON(value)
                        print("JSON: \(json)")
                        
                        if (json["status"].stringValue == "Authentication successful"){
                        
                        //SETTING NEW COUNTER FOR OTP
                        file["counter"].intValue = (file["counter"].intValue + 1)%10
                        UserDefaults.standard.set(file.rawString(), forKey: user)
                        UserDefaults.standard.synchronize()
                       
                        }
                        // Perform segue
                        self.performSegue(withIdentifier: "PINAuthSegue", sender: json["status"].stringValue)
                        
                    case .failure(let error):
                        print(error)
                        
                    }
                }

            }
            else {
            
            //Preparing call with wrong PIN
            //Generating fake OTP
                
                OTP = file["OTPlist"][counter]["OTP"].string
                let FakeOTP = Int(OTP!)!+1
                OTP = String(FakeOTP)
                let callURL = URL + "auth"
                let parameters: Parameters = ["user": user, "OTP": OTP!]
                print(parameters)
                
                Alamofire.request(callURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
                    
                    switch response.result{
                    case .success(let value):
                        let json = JSON(value)
                        print("JSON: \(json)")
                        
                        if (json["status"].stringValue == "Authentication successful"){
                            
                            //SETTING NEW COUNTER FOR OTP
                            file["counter"].intValue = (file["counter"].intValue + 1)%10
                            UserDefaults.standard.set(file.rawString(), forKey: user)
                            UserDefaults.standard.synchronize()
                
                        }
                        // Perform segue
                        self.performSegue(withIdentifier: "PINAuthSegue", sender: json["status"].stringValue)
                        
                    case .failure(let error):
                        print(error)
                        
                    }
                }

            
            
            }
            
            
        }
        else {
            
            // Wrong user alert
            
            displayAlertMessage(userMessage: "No such user found, finish ID process first!")
            
            return
            
        }
        
    }
    @IBAction func Home(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "PINHomeSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
           print(sent)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlertMessage (userMessage: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Understood", style: .default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PINAuthSegue") {
            let destination = segue.destination as! SuccessViewController
            destination.sent = sender as! String?
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
