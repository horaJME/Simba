//
//  AuthViewController.swift
//  Simba
//
//  Created by Infinum on 12/01/17.
//  Copyright © 2017 Infinum. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AuthViewController: UIViewController {
    
    var OTP: String?
    
    

    //Alamofire completion handler functions
    //PIN POSTING FUNCTIONS
    
    func Auth(completionHandler: @escaping (String, Error?) -> ()){
        let otp = OTP
        let User = IDText.text!
        makeCall(User: User,OTP: otp!, completionHandler: completionHandler)
    }
    
    func makeCall (User: String, OTP: String, completionHandler: @escaping (String, Error?) -> ()){
        
        let callURL = URL + "auth"
        
        let parameters: Parameters = ["user": User, "OTP": OTP]
        
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


    @IBOutlet weak var PINText: UITextField!
    @IBOutlet weak var IDText: UITextField!
    
    @IBAction func Home(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "AuthHomeSegue", sender: self)
        
    }
    
    @IBAction func SendPIN(_ sender: UIButton) {
        
        // Read into OTP list file
        // Check if user and PIN match
        
        
        
        if (IDText.text?.isEmpty ?? true){
            
            // Empty form alert
            
            displayAlertMessage(userMessage: "Please enter ID")
            
            return
            
        }
        else if (PINText.text?.isEmpty ?? true){
            
            // Empty form alert
            
            displayAlertMessage(userMessage: "Please enter PIN")
            
            return
            
        }
        else {
            
            //Future versions reading from file!!!
            let user = OTPlist["user"].stringValue
            let counter = OTPlist["counter"].intValue
            /////
        
            print(user)
            print(counter)
            
            OTP = OTPlist["OTPlist"][counter]["OTP"].string
            
            let callURL = URL + "auth"
            
            let parameters: Parameters = ["user": user, "OTP": OTP!]

            print(parameters)
            
            
            Alamofire.request(callURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
                
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    
                    
                    //SETTING NEW COUNTER FOR OTP
                    //WRITING INTO FILE IN FUTURE VERSION
                    OTPlist["counter"].intValue = OTPlist["counter"].intValue + 1
                    
                    
                    
                    print("JSON: \(json)")
                case .failure(let error):
                    print(error)
                    
                }
            }
            
            
            // Perform segue
            
            performSegue(withIdentifier: "SuccessSegue", sender: self)
            
            
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
