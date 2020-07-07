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

var reverseButtonHistory: [String] = Array(buttonHistory.reversed())

var timeButtomHistory: [String] = []

var reverseTimeButtonHistory: [String] = Array(timeButtomHistory.reversed())

var currentDateTime = Date()

let dateFormatter = DateFormatter()

var profileName = ""

var defaultProfileName = "User"



class ViewController: UIViewController {

   
     
    let networkQue = DispatchQueue.global(qos: .background)
    
     let hQueue = DispatchQueue.global(qos: .background)
    
    weak var timer: Timer?
    
    @IBOutlet var leading: NSLayoutConstraint!
    
    @IBOutlet var trailing: NSLayoutConstraint!
    
    var menuOut = false

    @IBOutlet weak var Status: UILabel!
    
    @IBOutlet weak var AI: UIImageView!
    
    @IBOutlet weak var Idle: UILabel!
    
    @IBOutlet weak var Pattern1Button: UIButton!
    
    @IBOutlet weak var signStatus: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIImageView!
    
    @IBOutlet weak var CP: UIButton!
    
    @IBOutlet weak var OFF: UIButton!
    
    @IBOutlet weak var Strobe: UIButton!
    
    @IBOutlet weak var Police: UIButton!
    
    @IBOutlet weak var RED: UIButton!
    
    @IBOutlet weak var Green: UIButton!
    
    @IBOutlet weak var Blue: UIButton!

    @IBOutlet weak var Prog: UIActivityIndicatorView!
    
    

    override func viewDidLoad() {
            dateFormatter.timeStyle = .medium
        
         defaults.set(defaultHistoryState, forKey: "defaultHistoryState")
        
        defaults.set(defaultProfileName, forKey: "defaultProfileName")
        
        buttonHistory = defaults.stringArray(forKey: "buttonHistory") ?? [String]()
        timeButtomHistory = defaults.stringArray(forKey: "timeButtomHistory") ?? [String]()
        
        profileName = defaults.string(forKey: "profileName") ?? defaults.value(forKey: "defaultProfileName") as! String
        
        self.signStatus.image?.withRenderingMode(.alwaysTemplate)
         self.signStatus.tintColor = UIColor.gray
       
        super.viewDidLoad()
           
        DispatchQueue.main.async {
             self.AI.isHidden = false
               self.Idle.isHidden = false
               self.Prog.stopAnimating()
        }

        
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
    
    @IBAction func menuTapped(_ sender: Any) {
           if menuOut == false {
               leading.constant = 300
               trailing.constant = -300
               menuOut = true
           } else {
               leading.constant = 0
               trailing.constant = 0
                menuOut = false
               
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
     self.AI.isHidden = false
     self.Idle.isHidden = false
     
    self.Prog.stopAnimating()
    lastButtonPressed = "Rainbow"
    self.updateHistory()
    }
 
        task.resume()
    }
    
    @IBAction func OFF(_ sender: Any) {
       DispatchQueue.main.async {
           self.AI.isHidden = true
           self.Idle.isHidden = true
           self.Prog.startAnimating()
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
            self.AI.isHidden = false
            self.Idle.isHidden = false
            self.Prog.stopAnimating()
            
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
        self.AI.isHidden = false
        self.Idle.isHidden = false
        self.Prog.stopAnimating()
        
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
         self.AI.isHidden = false
         self.Idle.isHidden = false
         self.Prog.stopAnimating()
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
          self.AI.isHidden = false
          self.Idle.isHidden = false
          self.Prog.stopAnimating()
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
          self.AI.isHidden = false
          self.Idle.isHidden = false
          self.Prog.stopAnimating()
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
        self.AI.isHidden = false
        self.Idle.isHidden = false
        self.Prog.stopAnimating()
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
        DispatchQueue.main.async {
            self.AI.isHidden = true
            self.Idle.isHidden = true
            self.Prog.startAnimating()
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
