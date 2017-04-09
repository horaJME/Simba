//
//  ViewController.swift
//  Simba
//
//  Created by Infinum on 11/01/17.
//  Copyright © 2017 Infinum. All rights reserved.
//

import UIKit

var DocList = ["mh47330","rw00006","kd35353"]
var PIN = ""
let URL = "http://192.168.5.10/my-rest-api/api/"

class ViewController: UIViewController {

    @IBAction func IdentificationButton(_ sender: UIButton) {
        print("ID Process initiated!")
        performSegue(withIdentifier: "IDSegue", sender: self)
        
    }    
    
    @IBAction func AuthButton(_ sender: UIButton) {
        print("Auth Process initiated!")
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

