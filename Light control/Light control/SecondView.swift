//
//  SecondView.swift
//  Light control
//
//  Created by Vasilis Michalakis on 19/6/20.
//  Copyright © 2020 Vasilis Michalakis. All rights reserved.
//

import UIKit
import WebKit

class SecondView: UIViewController, WKUIDelegate {

    
    
    
     @IBOutlet var colourPicker: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
       colourPicker = WKWebView(frame: .zero, configuration: webConfiguration)
        colourPicker.uiDelegate = self
        view = colourPicker
    }
    override func viewDidLoad() {
        if darkModeState == "On"{
                   overrideUserInterfaceStyle = .dark
                   
               }
               
               else {
                   overrideUserInterfaceStyle = .light
               }
        super.viewDidLoad()
  let myURL = URL(string:"\(IPADRESS)")
        let myRequest = URLRequest(url: myURL!)
       colourPicker.load(myRequest)
    }}
    /*
     @IBOutlet weak var colourPicker: WKWebView!
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


