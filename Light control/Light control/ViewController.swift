//
//  ViewController.swift
//  Light control
//
//  Created by Vasilis Michalakis on 17/6/20.
//  Copyright © 2020 Vasilis Michalakis. All rights reserved.
//currentDateTime = Date() use to set time
//    \(dateFormatter.string(from: currentDateTime)) use to add time value

import UIKit

import Foundation

let defaults = UserDefaults.standard

var IP = ""

var queueState = "on"

var IPADRESS = "http://\(IP)"

var highestNumber = Int.max

var lastButtonPressed = ""

var buttonHistory: [String] = []

var logoImages = [
    UIImage(systemName: "lightbulb.fill"),
    UIImage(systemName: "light.min"),
    UIImage(systemName: "badge.plus.radiowaves.right"),
    UIImage(systemName: "bolt.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)),
    UIImage(systemName: "burst", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)),
]

var logoImages2 = [
   
UIImage(systemName: "lightbulb"),
    
    UIImage(systemName: "lightbulb.slash.fill"),
   
    
   
    UIImage(systemName: "airplayvideo"),
    
   
    
    UIImage(systemName: "bolt.circle.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)),
    
    
    
    UIImage(systemName: "bolt.horizontal.circle.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)),
    
    
    
    UIImage(systemName: "burst.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)),
   
]

var logoImages3 = [
 UIImage(systemName: "lightbulb.slash"),
  UIImage(systemName: "airplayaudio"),
  UIImage(systemName: "bolt.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)),
  UIImage(systemName: "bolt.horizontal.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)),
 UIImage(systemName: "bolt", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)),
  
  
]

var logoImages4 = [
UIImage(systemName: "light.max"),

   UIImage(systemName: "command", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)),
 UIImage(systemName: "bolt.horizontal", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)),
 UIImage(systemName: "burn", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)),
 
 UIImage(systemName: "bolt.horizontal.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)),
    

]

var colorArray1 = [
    UIColor.red,
    UIColor.green,
    
]

var colorArray2 = [
    
    UIColor.blue,
    UIColor.orange,
   
]

var colorArray3 = [
    UIColor.yellow,
    UIColor.systemIndigo,
  
]

var colorArray4 = [
    UIColor.black,
    UIColor.white
]



var reverseButtonHistory: [String] = Array(buttonHistory.reversed())

var timeButtomHistory: [String] = []

var reverseTimeButtonHistory: [String] = Array(timeButtomHistory.reversed())

var currentDateTime = Date()

let dateFormatter = DateFormatter()

var profileName = ""

var defaultProfileName = "User"

var customPatternsChosen: [String] = []



class ViewController: UIViewController {

   
    @IBOutlet weak var Settings: UIButton!
    
    @IBOutlet weak var HistoryButtonMenu: UIButton!
    
    @IBOutlet weak var CLPButton: UIButton!
    
    @IBOutlet weak var CPB: UIButton!
    
    
    let networkQue = DispatchQueue.global(qos: .background)
    
     let hQueue = DispatchQueue.global(qos: .background)

    
    weak var timer: Timer?
    
    @IBOutlet var leading: NSLayoutConstraint!
    
    @IBOutlet var trailing: NSLayoutConstraint!
    
    var menuOut = false

    @IBOutlet weak var Status: UILabel!
    

    
   
    
    @IBOutlet weak var Pattern1Button: UIButton!
    
    @IBOutlet weak var signStatus: UIImageView!
    

    
    @IBOutlet weak var CP: UIButton!
    
    @IBOutlet weak var OFF: UIButton!
    
    @IBOutlet weak var Strobe: UIButton!
    
    @IBOutlet weak var Police: UIButton!
    
    @IBOutlet weak var RED: UIButton!
    
    @IBOutlet weak var Green: UIButton!
    
    @IBOutlet weak var Blue: UIButton!

        
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.main.async{
        super.viewDidAppear(animated)
        
            if darkModeState == "On"{
        self.overrideUserInterfaceStyle = .dark
              
          }
          
          else {
        self.overrideUserInterfaceStyle = .light
                
          }
        }
        
        
    }
    

    override func viewDidLoad() {

      
        
        defaults.set(defaultDarkModeState, forKey: "defaultDarkModeState")
        
          darkModeState = defaults.string(forKey: "darkModeState") ?? defaults.value(forKey: "defaultDarkModeState") as! String
        
       
      
        
        dateFormatter.timeStyle = .medium
        
         defaults.set(defaultHistoryState, forKey: "defaultHistoryState")
        
        defaults.set(defaultProfileName, forKey: "defaultProfileName")
        
        buttonHistory = defaults.stringArray(forKey: "buttonHistory") ?? [String]()
        timeButtomHistory = defaults.stringArray(forKey: "timeButtomHistory") ?? [String]()
        
        profileName = defaults.string(forKey: "profileName") ?? defaults.value(forKey: "defaultProfileName") as! String
        
        self.signStatus.image?.withRenderingMode(.alwaysTemplate)
         self.signStatus.tintColor = UIColor.gray
       
        super.viewDidLoad()
           
       
        
         HistoryState = defaults.string(forKey: "savedHistoryState") ?? defaults.value(forKey: "defaultHistoryState") as! String
        
          defaults.set(defaultIP, forKey: "defaultIP")
        
        if IP == ""{
            
            IP = defaults.string(forKey: "lastIP") ?? defaults.value(forKey: "defaultIP") as! String
            IPADRESS = "http://\(IP)"
        }
    
        
     networkQue.async{
        print("checking URL")
         let hostUrl: String = IPADRESS
         if let url = URL(string: hostUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            URLSession(configuration: .default)
            .dataTask(with: request) { (_, response, error) -> Void in
               guard error == nil else {
                  print("Error:", error ?? "")
                  DispatchQueue.main.async{
                            self.signStatus.image?.withRenderingMode(.alwaysTemplate)
                            self.signStatus.tintColor = UIColor.red
                                                            }
                return
               }
               guard (response as? HTTPURLResponse)?
               .statusCode == 200 else {
                  print("The host is down")
                  DispatchQueue.main.async{
    self.signStatus.image?.withRenderingMode(.alwaysTemplate)
    self.signStatus.tintColor = UIColor.red
                                    }
                return
               }
               print("The host is up and running")
                DispatchQueue.main.async{
        self.signStatus.image?.withRenderingMode(.alwaysTemplate)
        self.signStatus.tintColor = UIColor.green
                    
                }
            }
            .resume()
         }
            
       
        
       
        }
    startTimer()
        
    

    
            
        
        
       
    }

    
    func startTimer() {
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            self?.CheckNetworkStatus()
        }
    }
    
    func updateHistory(){
        let anotherValue = lastButtonPressed
        buttonHistory.append(anotherValue)
         print(lastButtonPressed)

        reverseButtonHistory = Array(buttonHistory.reversed())
        print (reverseButtonHistory)
        
        currentDateTime = Date()
    
        let yetAnotherValue = dateFormatter.string(from: currentDateTime)
        
        timeButtomHistory.append(yetAnotherValue)
        
        reverseTimeButtonHistory = Array(timeButtomHistory.reversed())
        
        defaults.set(buttonHistory, forKey: "buttonHistory")
        defaults.set(timeButtomHistory, forKey: "timeButtomHistory")
    }
    
    @IBAction func SBPT(_ sender: Any) {
    leading.constant = 0
                 trailing.constant = 0
                  menuOut = false
    }
    
    @IBAction func HBPT(_ sender: Any) {
    leading.constant = 0
                 trailing.constant = 0
                  menuOut = false
    }
    
    @IBAction func CLPPT(_ sender: Any) {
    leading.constant = 0
                 trailing.constant = 0
                  menuOut = false
    }
    
    @IBAction func CPPT(_ sender: Any) {
    leading.constant = 0
                 trailing.constant = 0
                  menuOut = false
    }
    
    
    
    @IBAction func menuTapped(_ sender: Any) {
           if menuOut == false {
               leading.constant = 300
               trailing.constant = -300
               menuOut = true
            if darkModeState == "On"{
                      overrideUserInterfaceStyle = .dark
                      
                  }
                  
                  else {
                      overrideUserInterfaceStyle = .light
                  }
           } else {
               leading.constant = 0
               trailing.constant = 0
                menuOut = false
            if darkModeState == "On"{
                      overrideUserInterfaceStyle = .dark
                      
                  }
                  
                  else {
                      overrideUserInterfaceStyle = .light
                  }
               
           }
       
       
       }
    
    @IBAction func Swiped(_ sender: Any) {
        if menuOut == false {
            leading.constant = 300
            trailing.constant = -300
            menuOut = true
            if darkModeState == "On"{
                      overrideUserInterfaceStyle = .dark
                      
                  }
                  
                  else {
                      overrideUserInterfaceStyle = .light
                  }
        }
        else {
            return
        }
    }
    
    @IBAction func Swiped2(_ sender: Any) {
        if menuOut == true{
            leading.constant = 0
            trailing.constant = 0
             menuOut = false
            if darkModeState == "On"{
                      overrideUserInterfaceStyle = .dark
                      
                  }
                  
                  else {
                      overrideUserInterfaceStyle = .light
                  }
        }
        else {
            return
        }
    }
    
    
   
    
    @IBAction func Pattern1Button(_ sender: UIButton) {
        LEDOFF()
         self.Status.text = "Rainbow"
        let url = URL(string: IPADRESS + "/Rainbow")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
  
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
          
            
           
            
        }
       
        print("button works")
 DispatchQueue.main.async {
   
    lastButtonPressed = "Rainbow"
    self.updateHistory()
    }
 
        task.resume()
    }
    
    @IBAction func OFF(_ sender: Any) {
       DispatchQueue.main.async {
       
            self.Status.text = "OFF"
        }
       
        let url = URL(string: IPADRESS + "/LED=OFF")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
   
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
       
            
            
            
        }
        print("button works")
          
        DispatchQueue.main.async {
           
            
            lastButtonPressed = "Off"
               self.updateHistory()
        }
       task.resume()
    }
    
     
    
    @IBAction func Strobe(_ sender: Any) {
        LEDOFF()
       self.Status.text = "Strobe"
        let url = URL(string: IPADRESS + "/pattern3")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
            
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            
            
            
            
        }
         
        print("button works")
    DispatchQueue.main.async {
        
        
        lastButtonPressed = "Strobe"
           self.updateHistory()
    }
        task.resume()
    }
    
    @IBAction func Police(_ sender: Any) {
        LEDOFF()
        self.Status.text = "Police"
        let url = URL(string: IPADRESS + "/pattern2")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
       
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
           
            
            
        }
        print("button works")
     DispatchQueue.main.async {
       
        lastButtonPressed = "Police"
           self.updateHistory()
     }
        task.resume()
    }
    
    @IBAction func RED(_ sender: Any) {
        LEDOFF()
        self.Status.text = "Red"
        let url = URL(string: IPADRESS + "/Strip=RED")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
          
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
              
            
           
       
        }
        print("button works")
      DispatchQueue.main.async {
         
        lastButtonPressed = "Red"
           self.updateHistory()
      }
        task.resume()
    }
    
    @IBAction func Green(_ sender: Any) {
        LEDOFF()
        self.Status.text = "Green"
        let url = URL(string: IPADRESS + "/Strip=Green")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
       
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
          
            
            
         
        }
        print("button works")
      DispatchQueue.main.async {
        
        lastButtonPressed = "Green"
           self.updateHistory()
      }
        task.resume()
    }
    
    @IBAction func Blue(_ sender: Any) {
        LEDOFF()
        self.Status.text = "Blue"
        let url = URL(string: IPADRESS + "/Strip=Blue")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
      
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
          
            
           
            
        
        }
        print("button works")
    DispatchQueue.main.async {
       
        lastButtonPressed = "Blue"
           self.updateHistory()
    }
        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func LEDOFF(){
        
        let url = URL(string: IPADRESS + "/LED=OFF")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        }
       
        print("button works")
         
        task.resume()
    }
  
    
    @IBAction func CP(_ sender: Any) {
    
    
    let url = URL(string: IPADRESS + "/colopicke")
     guard let requestUrl = url else { fatalError() }
     // Prepare URL Request Object
     var request = URLRequest(url: requestUrl)
     request.httpMethod = "POST"
     
     
     // HTTP Request Parameters which will be sent in HTTP Request Body
     let postString = "";
     // Set HTTP Request Body
     request.httpBody = postString.data(using: String.Encoding.utf8);
     // Perform HTTP Request
     let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
     }
    
     print("button works")
     
     task.resume()


}
   
    
    
    

    func CheckNetworkStatus() {
      

        
        networkQue.async {
            print(IP)
            let hostUrl: String = IPADRESS
                 if let url = URL(string: hostUrl) {
                    var request = URLRequest(url: url)
                    request.httpMethod = "GET"
                    URLSession(configuration: .default)
                    .dataTask(with: request) { (_, response, error) -> Void in
                       guard error == nil else {
                          print("Error:", error ?? "")
                          DispatchQueue.main.async{
                          self.signStatus.image?.withRenderingMode(.alwaysTemplate)
                          self.signStatus.tintColor = UIColor.red
                                                          }
                        return
                       }
                       guard (response as? HTTPURLResponse)?
                      .statusCode == 200 else {
                          print("The host is down")
                          DispatchQueue.main.async{
            self.signStatus.image?.withRenderingMode(.alwaysTemplate)
            self.signStatus.tintColor = UIColor.red
                                            }
                        return
                       }
                       print("The host is up and running")
                        DispatchQueue.main.async{
                self.signStatus.image?.withRenderingMode(.alwaysTemplate)
                self.signStatus.tintColor = UIColor.green
                            
                        }
                    }
                    .resume()
                 }
        }
        
        
    }



  


}
