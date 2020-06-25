//
//  Settings.swift
//  Light control
//
//  Created by Vasilis Michalakis on 25/6/20.
//  Copyright © 2020 Vasilis Michalakis. All rights reserved.
//

import UIKit

class Settings: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet var IPInput: UITextField!
    
    @IBOutlet var Connect: UIButton!
    
    @IBAction func Sub(_ sender: Any) {
   
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
