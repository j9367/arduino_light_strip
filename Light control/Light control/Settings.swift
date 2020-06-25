//
//  Settings.swift
//  Light control
//
//  Created by Vasilis Michalakis on 25/6/20.
//  Copyright © 2020 Vasilis Michalakis. All rights reserved.
//

import UIKit

var lastIP = ""

class Settings: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    lastIP = "172.20.10.11"
    
    @IBOutlet var IPInput: UITextField!
    
    @IBOutlet var Connect: UIButton!
    
    @IBAction func Sub(_ sender: Any) {
   
    
        lastIP = IP
        IP = IPInput.text!
        print(IP)
       IPADRESS = "http://" + IP
        print(IPADRESS)
        
    
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
