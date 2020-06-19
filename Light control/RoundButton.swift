//
//  RoundButton.swift
//  Light control
//
//  Created by Vasilis Michalakis on 18/6/20.
//  Copyright © 2020 Vasilis Michalakis. All rights reserved.
//

import Foundation

@IBDesignable
   class RoundButton: UIButton {

       @IBInspectable var cornerRadius: CGFloat = 0{
           didSet{
           self.layer.cornerRadius = cornerRadius
           }
       }

       @IBInspectable var borderWidth: CGFloat = 0{
           didSet{
               self.layer.borderWidth = borderWidth
           }
       }

       @IBInspectable var borderColor: UIColor = UIColor.clear{
           didSet{
               self.layer.borderColor = borderColor.cgColor
           }
       }
   }
