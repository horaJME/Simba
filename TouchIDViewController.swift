//
//  TouchIDViewController.swift
//  Simba
//
//  Created by Infinum on 15/01/17.
//  Copyright © 2017 Infinum. All rights reserved.
//

import UIKit
import SwiftyJSON
import Locksmith
import LocalAuthentication

class TouchIDViewController: UIViewController {

    var user: String?

    @IBAction func FinishButton(_ sender: UIButton) {
        
        //Setting label in saved info not to use TouchID
        let value = UserDefaults.standard.string(forKey: user!)
        var file = JSON.init(parseJSON: value!)
        file["TouchID"].intValue = 0
        UserDefaults.standard.set(file.rawString(), forKey:user!)
        UserDefaults.standard.synchronize()
        
    }
    
    @IBAction func ConfigureTouchID(_ sender: AnyObject) {
        
        //Setting label in saved info to use TouchID
        let value = UserDefaults.standard.string(forKey: user!)
        var file = JSON.init(parseJSON: value!)
        
        //Touch ID setup
        
        let authenticationContext = LAContext()
        var error: NSError?
        
        if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Touch to setup Touch ID for authentication.", reply: { (success: Bool, error: Error?) in
                //If successful reading fingerprint
                if success {
                    
                    file["TouchID"].intValue = 1
                    let PIN = file["PIN"].stringValue
                    UserDefaults.standard.set(file.rawString(), forKey:self.user!)
                    UserDefaults.standard.synchronize()
                    
                    //Saving PIN into keychain
                    do {
                        try Locksmith.saveData(data: ["PIN": PIN], forUserAccount: self.user!)
                    }
                    catch {
                        //Could not save PIN to keychain
                        print("Failed saving PIN to keychain!")
                    }
                    
                    // Perform segue
                    
                    self.displayAlertMessageSegue(userMessage: "TouchID successfully set up")
                    
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
    
    func displayAlertMessageSegue (userMessage: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Understood", style: .default, handler: { action in self.performSegue(withIdentifier: "FinishSegue", sender: self)})
        
        myAlert.addAction(okAction)
        
        let imageView = UIImageView(frame: CGRect(x:220,y:40,width:90,height:90))
        
        imageView.image = #imageLiteral(resourceName: "TouchID")
        
        myAlert.view.addSubview(imageView)
        
        
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
