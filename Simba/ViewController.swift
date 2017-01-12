//
//  ViewController.swift
//  Simba
//
//  Created by Infinum on 11/01/17.
//  Copyright © 2017 Infinum. All rights reserved.
//

import UIKit

var ID = ""
var PIN = ""

class ViewController: UIViewController {

    @IBAction func IdentificationButton(_ sender: UIButton) {
        print("ID Process initiated!")
        performSegue(withIdentifier: "IDSegue", sender: self)
        
    }    
    
    @IBAction func AuthButton(_ sender: UIButton) {
        print("Auth Process initiated!")
        print(ID)
        print(PIN)
        performSegue(withIdentifier: "AuthSegue", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

