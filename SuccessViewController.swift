//
//  SuccessViewController.swift
//  Simba
//
//  Created by Infinum on 12/01/17.
//  Copyright © 2017 Infinum. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {
    
    var sent: String?
    
    @IBOutlet weak var AuthResult: UILabel!
    @IBOutlet weak var AuthImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (sent!=="Authentication successful") {
        
            AuthResult.text = "Authentication successful!"
            AuthImage.image = UIImage(named: "TouchID")
            
        } else {
            
            AuthResult.text = "Authentication failed!"
            AuthImage.image = UIImage(named: "TouchID2")
        
        }
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
    
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
