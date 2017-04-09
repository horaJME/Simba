//
//  PINViewController.swift
//  Simba
//
//  Created by Infinum on 12/01/17.
//  Copyright © 2017 Infinum. All rights reserved.
//

import UIKit
import Alamofire

class PINViewController: UIViewController {
    
    //Variable passed through ID segue
    
    var user: String?
    
    //Alamofire completion handler functions
    
    func setPIN(completionHandler: @escaping (String, Error?) -> ()){
        let User = user
        makeCall(User: User!, completionHandler: completionHandler)
    }
    
    func makeCall (User: String, completionHandler: @escaping (String, Error?) -> ()){
        
        let callURL = URL + "PIN"
        
        Alamofire.request(callURL).validate().responseString { response in
            
            switch response.result{
            case .success(let value):
                let result = response.result.value! // result of response serialization
                print(result)
                print("Communication Successful!")
                completionHandler(value, nil)
            case .failure(let Error):
                print(Error)
                print("Communication cannot be established!")
                completionHandler(Error as! String, nil)
            }
        }
        
    }


    @IBOutlet weak var PINtext: UITextField!
    @IBOutlet weak var PINretext: UITextField!
    
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
            //MOZDA POSLAT I KORISNIKA NEKIM PUTEM
            //POST USER I PIN
            
            PIN = PINtext.text!
            
            // Perform segue
            
            //PREUZET DATOTEKU S OTPOVIMA
            
            performSegue(withIdentifier: "PINSegue", sender: self)
            
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
