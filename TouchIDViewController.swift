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
        file["TouchID"].intValue = 1
        UserDefaults.standard.set(file.rawString(), forKey:user!)
        UserDefaults.standard.synchronize()
        // Perform segue
        self.performSegue(withIdentifier: "FinishSegue", sender: self)
        
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
