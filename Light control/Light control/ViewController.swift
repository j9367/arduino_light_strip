//
//  ViewController.swift
//  Light control
//
//  Created by Vasilis Michalakis on 17/6/20.
//  Copyright © 2020 Vasilis Michalakis. All rights reserved.


import UIKit

var IP = "172.20.10.11"

class ViewController: UIViewController {

    var IPADRESS = "http://" + IP
    
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
    

    
    
    
    
   
    
    
    override func viewDidLoad() {
        self.signStatus.image?.withRenderingMode(.alwaysTemplate)
         self.signStatus.tintColor = UIColor.gray
       
        super.viewDidLoad()
            checkIsConnectedToNetwork()
        DispatchQueue.main.async {
             self.AI.isHidden = false
               self.Idle.isHidden = false
               self.Prog.stopAnimating()
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
          checkIsConnectedToNetwork()
        DispatchQueue.main.async {
            self.AI.isHidden = false
            self.Idle.isHidden = false
            self.Prog.stopAnimating()
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
   
    
    func checkIsConnectedToNetwork() {
       let hostUrl: String = IPADRESS
       if let url = URL(string: hostUrl) {
          var request = URLRequest(url: url)
          request.httpMethod = "HEAD"
          URLSession(configuration: .default)
          .dataTask(with: request) { (_, response, error) -> Void in
             guard error == nil else {
                print("Error:", error ?? "")
            DispatchQueue.main.async {
                self.signStatus.image?.withRenderingMode(.alwaysTemplate)
            self.signStatus.tintColor = UIColor.red
                }
                return
             
            }
             guard (response as? HTTPURLResponse)?
             .statusCode == 200 else {
                print("The host is down")
                 DispatchQueue.main.async {
                self.signStatus.image?.withRenderingMode(.alwaysTemplate)
                           self.signStatus.tintColor = UIColor.red
                }
                return
             }
             print("The host is up and running")
            DispatchQueue.main.async {
            self.signStatus.image?.withRenderingMode(.alwaysTemplate)
            self.signStatus.tintColor = UIColor.green
            }
            
        }
        
        .resume()
        }
        }
 
}





  


