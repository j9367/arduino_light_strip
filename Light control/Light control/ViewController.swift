//
//  ViewController.swift
//  Light control
//
//  Created by Vasilis Michalakis on 17/6/20.
//  Copyright © 2020 Vasilis Michalakis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    
    
    @IBOutlet weak var Pattern1Button: UIView!
    
    @IBOutlet weak var progressBarView: UIProgressView!
    
    @IBOutlet weak var OFF: UIButton!
    
    @IBOutlet weak var Strobe: UIButton!
    
    @IBOutlet weak var Police: UIButton!
    
    @IBOutlet weak var RED: UIButton!
    
    @IBOutlet weak var Green: UIButton!
    
    @IBOutlet weak var Blue: UIButton!
    
    @IBOutlet weak var School: UIButton!
    
    @IBOutlet weak var Home: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       Pattern1Button.layer.cornerRadius = 4
        OFF.layer.cornerRadius = 4
        // Do any additional setup after loading the view, typically from a nib.
        //test
    }

  
   
    
    
    @IBAction func Pattern1Button(_ sender: UIButton) {
        LEDOFF()
        let url = URL(string: "http://172.20.10.11/Rainbow")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        self.progressBarView.progress = 0.65
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            self.progressBarView.progress = 0.8
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                self.progressBarView.progress = 1.0
                  self.progressBarView.progress = 0.0
                return
              
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        self.progressBarView.progress = 1.0
          self.progressBarView.progress = 0.0
        print("button works")
        task.resume()
    }
    
    @IBAction func OFF(_ sender: Any) {
        let url = URL(string: "http://172.20.10.11/LED=OFF")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        self.progressBarView.progress = 0.65
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        self.progressBarView.progress = 0.8
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                self.progressBarView.progress = 1.0
                  self.progressBarView.progress = 0.0
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        print("button works")
         self.progressBarView.progress = 1.0
        self.progressBarView.progress = 0.0
       task.resume()
    }
    
    
    @IBAction func Strobe(_ sender: Any) {
        LEDOFF()
        let url = URL(string: "http://172.20.10.11/pattern3")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
            self.progressBarView.progress = 0.6
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
             self.progressBarView.progress = 0.8
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                 self.progressBarView.progress = 1.0
                  self.progressBarView.progress = 0.0
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
         self.progressBarView.progress = 1.0
          self.progressBarView.progress = 0.0
        print("button works")
        task.resume()
    }
    
    @IBAction func Police(_ sender: Any) {
        LEDOFF()
        let url = URL(string: "http://172.20.10.11/pattern2")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        self.progressBarView.progress = 0.6
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            self.progressBarView.progress = 0.8
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                self.progressBarView.progress = 1.0
                  self.progressBarView.progress = 0.0
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        print("button works")
        self.progressBarView.progress = 1.0
          self.progressBarView.progress = 0.0
        task.resume()
    }
    
    @IBAction func RED(_ sender: Any) {
        LEDOFF()
        let url = URL(string: "http://172.20.10.11/Strip=RED")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
           self.progressBarView.progress = 0.6
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
               self.progressBarView.progress = 0.8
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                self.progressBarView.progress = 1.0
                  self.progressBarView.progress = 0.0
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        print("button works")
        self.progressBarView.progress = 1.0
          self.progressBarView.progress = 0.0
        task.resume()
    }
    
    @IBAction func Green(_ sender: Any) {
        LEDOFF()
        let url = URL(string: "http://172.20.10.11/Strip=Green")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        self.progressBarView.progress = 0.6
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
           self.progressBarView.progress = 0.8
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                self.progressBarView.progress = 1.0
                  self.progressBarView.progress = 0.0
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        print("button works")
        self.progressBarView.progress = 1.0
          self.progressBarView.progress = 0.0
        task.resume()
    }
    
    @IBAction func Blue(_ sender: Any) {
        LEDOFF()
        let url = URL(string: "http://172.20.10.11/Strip=Blue")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        self.progressBarView.progress = 0.6
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
           self.progressBarView.progress = 0.8
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                self.progressBarView.progress = 1.0
                  self.progressBarView.progress = 0.0
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        print("button works")
        self.progressBarView.progress = 1.0
          self.progressBarView.progress = 0.0
        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func LEDOFF(){
        progressBarView.progress = 0.0
        let url = URL(string: "http://172.20.10.11/LED=OFF")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        progressBarView.progress = 0.125
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
         self.progressBarView.progress = 0.25
            // Check for Error
           
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        print("button works")
         self.progressBarView.progress = 0.5
        task.resume()
    }
  
    

}





   

