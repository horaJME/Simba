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
import LocalAuthentication

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



    @IBOutlet weak var IDText: UITextField!
    
    @IBAction func Home(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "AuthHomeSegue", sender: self)
        
    }
    
    @IBAction func SendPIN(_ sender: UIButton) {
        
        let user: String
        let counter: Int
        
        if (IDText.text?.isEmpty ?? true){
            
            // Empty form alert
            
            displayAlertMessage(userMessage: "Please enter ID")
            
            return
            
        } else if let value = UserDefaults.standard.string(forKey: IDText.text!){
        
            // Read into OTP list file
            var file = JSON.init(parseJSON: value)
            user = file["user"].stringValue
            counter = file["counter"].intValue
            print(user)
            print(counter)
            
            //Preparing call
            OTP = file["OTPlist"][counter]["OTP"].string
            let callURL = URL + "auth"
            let parameters: Parameters = ["user": user, "OTP": OTP!]
            print(parameters)
            
            //Touch ID check
            
            let authenticationContext = LAContext()
            var error: NSError?
            
            if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Touch the Touch ID sensor to authenticate.", reply: { (success: Bool, error: Error?) in
                    //If successful reading fingerprint
                    if success {
                    
                        Alamofire.request(callURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
                            
                            switch response.result{
                            case .success(let value):
                                let json = JSON(value)
                                
                                //SETTING NEW COUNTER FOR OTP
                                file["counter"].intValue = (file["counter"].intValue + 1)%10
                                UserDefaults.standard.set(file.rawString(), forKey: user)
                                UserDefaults.standard.synchronize()
                                print("JSON: \(json)")
                                
                                // Perform segue
                                self.performSegue(withIdentifier: "SuccessSegue", sender: "Authentication successful")
                                
                            case .failure(let error):
                                print(error)
                                
                            }
                        }
                        
                    } else {
                        //Evaluating type of error that occured
                        if let evaluateError = error as? NSError {
                            let message = self.errorMessageForLAErrorCode(errorCode: evaluateError.code)
                            self.displayAlertMessage(userMessage: message)
                        }
                    }
                    
                })
            } else {
                self.displayAlertMessage(userMessage: "This device does not support Touch ID")
                return
            }
        }
        else {
            
            // Wrong user alert
            
            displayAlertMessage(userMessage: "No such user found, finish ID process first!")
            
            return
            
        }
    }
    
    //Error evaluation function
    
    func errorMessageForLAErrorCode(errorCode: Int) -> String {
        var message = ""
        
        switch errorCode {
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.touchIDLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.touchIDNotAvailable.rawValue:
            message = "TouchID is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
        }
        return message
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SuccessSegue") {
            let destination = segue.destination as! SuccessViewController
            destination.success = sender as! String?
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
