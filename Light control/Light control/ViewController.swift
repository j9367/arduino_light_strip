//
//  ViewController.swift
//  Light control
//
//  Created by Vasilis Michalakis on 17/6/20.
//  Copyright © 2020 Vasilis Michalakis. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

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

 
   
    
    
    override func viewDidLoad() {
    self.signStatus.image?.withRenderingMode(.alwaysTemplate)
         self.signStatus.tintColor = UIColor.gray
       
        super.viewDidLoad()
            checkIsConnectedToNetwork()
    }
    

    
  
    
   
    @IBAction func Pattern1Button(_ sender: UIButton) {
        LEDOFF()
         self.Status.text = "Rainbow"
        let url = URL(string: "http://172.20.10.11/Rainbow")
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
    
    @IBAction func OFF(_ sender: Any) {
       self.Status.text = "OFF"
        let url = URL(string: "http://172.20.10.11/LED=OFF")
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
       task.resume()
    }
    
     
    
    @IBAction func Strobe(_ sender: Any) {
        LEDOFF()
       self.Status.text = "Strobe"
        let url = URL(string: "http://172.20.10.11/pattern3")
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
    
    @IBAction func Police(_ sender: Any) {
        LEDOFF()
        self.Status.text = "Police"
        let url = URL(string: "http://172.20.10.11/pattern2")
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
    
    @IBAction func RED(_ sender: Any) {
        LEDOFF()
        self.Status.text = "Red"
        let url = URL(string: "http://172.20.10.11/Strip=RED")
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
    
    @IBAction func Green(_ sender: Any) {
        LEDOFF()
        self.Status.text = "Green"
        let url = URL(string: "http://172.20.10.11/Strip=Green")
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
    
    @IBAction func Blue(_ sender: Any) {
        LEDOFF()
        self.Status.text = "Blue"
        let url = URL(string: "http://172.20.10.11/Strip=Blue")
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func LEDOFF(){
       
        let url = URL(string: "http://172.20.10.11/LED=OFF")
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
    
    
    let url = URL(string: "http://172.20.10.11/colopicke")
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
       let hostUrl: String = "http://172.20.10.11"
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





  


