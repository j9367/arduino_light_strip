//
//  customLightPatterns.swift
//  Light control
//
//  Created by Vasilis Michalakis on 8/7/20.
//  Copyright © 2020 Vasilis Michalakis. All rights reserved.
//

import UIKit

var caseNumber = -1

var nameString: [String] = []

var nameString2: [String] = []

var ReversenameString: [String] = Array(nameString.reversed())

var ReversenameString2: [String] = Array(nameString2.reversed())

var imageString: [UIImage] = []

var imageString2: [UIImage] = []

var ReverseimageString: [UIImage] = Array(imageString.reversed())

var ReverseimageString2: [UIImage] = Array(imageString2.reversed())

var colorString: [UIColor] = []

var colorString2: [UIColor] = []

var reverseColorString: [UIColor] = Array(colorString.reversed())

var reverseColorString2: [UIColor] = Array(colorString2.reversed())

var tempName: String = ""

var colorTempVar: UIColor = UIColor.red

var image = UIImage(systemName: "lightbulb.fill")

class PickerCell: UITableViewCell{
    
    @IBOutlet weak var locoIcon: UIButton!
    
    @IBOutlet weak var LogoIcon: UIImageView!
    
    @IBOutlet weak var LogoIcon2: UIImageView!
    
    @IBOutlet weak var locoIcon2: UIButton!
    
    @IBOutlet weak var LogoIcon3: UIImageView!
    
    @IBOutlet weak var LogoIcon4: UIImageView!
    
    @IBOutlet weak var locoIcon3: UIButton!
    
    @IBOutlet weak var locoIcon4: UIButton!
    
}

class PickerCell2: UITableViewCell{
    
    @IBOutlet weak var PlogoIcon: UIImageView!
    
    @IBOutlet weak var PlogoIcon2: UIImageView!
    
    @IBOutlet weak var PlogoIcon3: UIImageView!
    
    @IBOutlet weak var PlogoIcon4: UIImageView!
    
    @IBOutlet weak var PlocoIcon1: UIButton!
    
    @IBOutlet weak var PlocoIcon2: UIButton!
    
    @IBOutlet weak var PlocoIcon3: UIButton!
    
    @IBOutlet weak var PlocoIcon4: UIButton!
    
}


class customLightPatterns: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var ChooserView: UIView!
    
    @IBOutlet weak var CustomName: UITextField!
    
    
    @IBOutlet weak var DoneButton: UIButton!
    
    let cellReuseIdentifier = "cell2"
    
   
    
     let hQueue = DispatchQueue.global(qos: .background)
    
    @IBOutlet weak var picker: UISegmentedControl!
    
    @IBOutlet weak var mainlogo: UIImageView!
    
    
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var Customtable: UITableView!
    

    override func viewDidLoad() {
      
      
        DoneButton.isHidden = true
        super.viewDidLoad()
        self.Customtable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
              Customtable.delegate = self
              Customtable.dataSource = self
        self.Customtable.rowHeight = 100.0
        
        
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func addNew(_ sender: Any) {
        ChooserView.isHidden = true
        if ChooserView.isHidden == true{
            plusButton.isHidden = true
            DoneButton.isHidden = false
            
        }
    }
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let selectedIndex = self.picker.selectedSegmentIndex
        switch selectedIndex{
        case 0:
           print ("LogoImages")
            return logoImages.count
            
        case 1:
            print("Color")
            return colorArray1.count
            
        default:
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2 = Customtable.dequeueReusableCell(withIdentifier: "Pcell") as! PickerCell
        
        let cell3 = Customtable.dequeueReusableCell(withIdentifier: "PC2") as! PickerCell2

       
        
        
         
        
            let selectedIndex = self.picker.selectedSegmentIndex
        switch selectedIndex{
            
        case 0:
            print("case0")
            caseNumber = 0
            
            
           cell2.selectionStyle = .none
            
            cell2.LogoIcon.backgroundColor = nil
            
           
            
             cell2.LogoIcon2.backgroundColor = nil
            
             cell2.LogoIcon3.backgroundColor = nil
            
             cell2.LogoIcon4.backgroundColor = nil
            
            cell2.LogoIcon.image = logoImages[indexPath.row]
            
            cell2.LogoIcon2.image = logoImages2[indexPath.row]
            
            cell2.LogoIcon3.image = logoImages3[indexPath.row]
            
            cell2.LogoIcon4.image = logoImages4[indexPath.row]
                  
            
           if caseNumber == 0{
            
                
                
            cell2.locoIcon.tag = indexPath.row
            
            cell2.locoIcon2.tag = indexPath.row
            
            cell2.locoIcon3.tag = indexPath.row
            
            cell2.locoIcon4.tag = indexPath.row
            
         
            
            cell3.PlocoIcon1.tag = 0
                                  
                                  cell3.PlocoIcon2.tag = 0
                                  
                                  cell3.PlocoIcon3.tag = 0
                                  
                                  cell3.PlocoIcon4.tag = 0
            
            cell2.locoIcon.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
               cell2.locoIcon2.addTarget(self, action: #selector(buttonTapped2(_:)), for: .touchUpInside)
            
             cell2.locoIcon3.addTarget(self, action: #selector(buttonTapped3(_:)), for: .touchUpInside)
              
             cell2.locoIcon4.addTarget(self, action: #selector(buttonTapped4(_:)), for: .touchUpInside)
             
            
            }
            
        return cell2
            
        case 1:
         print("case1")
            caseNumber = 1
        
            cell3.selectionStyle = .none
            
            cell3.PlogoIcon.image = nil
            
             cell3.PlogoIcon2.image = nil
            
             cell3.PlogoIcon3.image = nil
            
             cell3.PlogoIcon4.image = nil
            
            cell3.PlogoIcon.backgroundColor = colorArray1[indexPath.row]
            
            cell3.PlogoIcon2.backgroundColor = colorArray2[indexPath.row]
            
            cell3.PlogoIcon3.backgroundColor = colorArray3[indexPath.row]
            
            cell3.PlogoIcon4.backgroundColor = colorArray4[indexPath.row]
            
            if caseNumber == 1{
                
                
            
            cell3.PlocoIcon1.tag = indexPath.row
                
            
            cell3.PlocoIcon2.tag = indexPath.row
            
            cell3.PlocoIcon3.tag = indexPath.row
            
            cell3.PlocoIcon4.tag = indexPath.row
            
                
                cell2.locoIcon.tag = 0
                
                cell2.locoIcon2.tag = 0
                
                cell2.locoIcon3.tag = 0
                
                cell2.locoIcon4.tag = 0
          
            
            cell3.PlocoIcon1.addTarget(self, action: #selector(buttonTapped5(_:)), for: .touchUpInside)
                       
                          cell3.PlocoIcon2.addTarget(self, action: #selector(buttonTapped6(_:)), for: .touchUpInside)
                       
                        cell3.PlocoIcon3.addTarget(self, action: #selector(buttonTapped7(_:)), for: .touchUpInside)
                         
                        cell3.PlocoIcon4.addTarget(self, action: #selector(buttonTapped8(_:)), for: .touchUpInside)
             
         
            }
         
            return cell3
           
            
                    
        default:
            Customtable.reloadData()
            return UITableViewCell()
        }
        
    }
    
    @objc func buttonTapped(_ sender: UIButton){
        mainlogo.image = logoImages[sender.tag]
        
        print(sender.tag)
        }
    
    @objc func buttonTapped2(_ sender: UIButton){
            mainlogo.image = logoImages2[sender.tag]
        print (sender.tag)
    }
    
    @objc func buttonTapped3(_ sender: UIButton){
          
     
        mainlogo.image = logoImages3[sender.tag]
        print(sender.tag)
        
      }
    
    @objc func buttonTapped4(_ sender: UIButton){
       
         
        mainlogo.image = logoImages4[sender.tag]
        print(sender.tag)
        
        }
    
    @objc func buttonTapped5(_ sender: UIButton){
       
           
        mainlogo.tintColor = colorArray1[sender.tag]
                 print(sender.tag)
        
        
       }
       
       @objc func buttonTapped6(_ sender: UIButton){
           mainlogo.tintColor = colorArray2[sender.tag]
        print(sender.tag)
       }
       
       @objc func buttonTapped7(_ sender: UIButton){
        mainlogo.tintColor = colorArray3[sender.tag]
        print(sender.tag)
         }
       
       @objc func buttonTapped8(_ sender: UIButton){
             mainlogo.tintColor = colorArray4[sender.tag]
        print(sender.tag)
         }

    @IBAction func Change(_ sender: Any) {
        Customtable.reloadData()
    }
    
    @IBAction func DoneButtonIsPressed(_ sender: Any) {
        
        
        
        
        
        ChooserView.isHidden = false
        
        DoneButton.isHidden = true
        
        plusButton.isHidden = false
      
       NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
        
        if nameString.count >= nameString2.count{
            tempName = CustomName.text!
             
            let value = tempName
            
             nameString2.append(value)
            
            image = mainlogo.image
            
            imageString2.append(image!)
            
            colorTempVar = mainlogo.tintColor
            
            colorString2.append(colorTempVar)
        }
        else {

             tempName = CustomName.text!
             
             let value = tempName
             
             nameString.append(value)
            
             image = mainlogo.image
             
             imageString.append(image!)
             
             ReversenameString = nameString.reversed()
             
             ReverseimageString = imageString.reversed()
             
             colorTempVar = mainlogo.tintColor
             
             colorString.append(colorTempVar)
             
             reverseColorString = colorString.reversed()
        }
    }
}

