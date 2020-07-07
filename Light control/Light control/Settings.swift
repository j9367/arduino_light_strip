//
//  Settings.swift
//  Light control
//
//  Created by Vasilis Michalakis on 25/6/20.
//  Copyright © 2020 Vasilis Michalakis. All rights reserved.
//

import UIKit

var settingsState = "off"

var HistoryState = "off"

var savedHistoryState = ""

var lastIP = ""

var defaultIP = "172.20.10.11"



var defaultHistoryState = "on"


class Settings: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
      
        
      IPInput.placeholder = ("\(IP) - IP Adress")
    
        
        
        
        if HistoryState == "on" {
            HistorySwitch.setOn(true,
            animated: true)
        }
        // Do any additional setup after loading the view.
  
    
    }
    
   
    
    @IBOutlet var IPInput: UITextField!
    
    @IBOutlet weak var Confirm: UIButton!
    
    @IBOutlet weak var NameInput: UITextField!
    
    
    @IBOutlet var Connect: UIButton!
    
    @IBAction func Sub(_ sender: Any) {
   
        if IP == "" {
            lastIP = IP
        }
        
        lastIP = IP
        IP = IPInput.text!
        print(IP)
       IPADRESS = "http://" + IP
        print(IPADRESS)
        print(lastIP)
       
        defaults.set(lastIP, forKey: "lastIP")
     
    
    }
    
    @IBAction func changeName(_ sender: Any) {
        
        profileName = NameInput.text!
        defaults.set(profileName, forKey: "profileName")
    }
    
    
    @IBOutlet var DM: UISwitch!
    
    @IBOutlet weak var HistorySwitch: UISwitch!
    
    
    @IBOutlet var Notifications: UISwitch!
    
   
    @IBAction func ToggleSwitched(_ sender: Any) {
    if HistorySwitch.isOn {
       
        HistoryState = "on"
        print("on")
        
       
    } else {
        
        HistoryState = "off"
        print("off")
     
    }
    savedHistoryState = HistoryState
    defaults.set(savedHistoryState, forKey: "savedHistoryState")
         defaults.set(defaultHistoryState, forKey: "defaultHistoryState")
    print(savedHistoryState)
    }
    
    @IBAction func SaveValue(_ sender: Any) {
 
    }
    
    
    
    
}
