//
//  customLightPatterns.swift
//  Light control
//
//  Created by Vasilis Michalakis on 8/7/20.
//  Copyright © 2020 Vasilis Michalakis. All rights reserved.
//

import UIKit

var caseNumber = -1


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

class customLightPatterns: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    let cellReuseIdentifier = "cell2"
    
     let hQueue = DispatchQueue.global(qos: .background)
    
    @IBOutlet weak var picker: UISegmentedControl!
    
    @IBOutlet weak var mainlogo: UIImageView!
    
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var Customtable: UITableView!
    

    override func viewDidLoad() {
      
        print(darkModeState)
        
        if darkModeState == "On"{
                   overrideUserInterfaceStyle = .dark
                   
               }
               
               else {
                   overrideUserInterfaceStyle = .light
               }
        
        super.viewDidLoad()
        self.Customtable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
              Customtable.delegate = self
              Customtable.dataSource = self
        self.Customtable.rowHeight = 100.0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func plusButtonTouched(_ sender: Any) {
    

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
        
        let cell3 = Customtable.dequeueReusableCell(withIdentifier: "Pcell") as! PickerCell

        
        
            let selectedIndex = self.picker.selectedSegmentIndex
        switch selectedIndex{
            
        case 0:
            
            caseNumber = 0
            
            
            cell2.locoIcon.tag = 0
                       
                       cell2.locoIcon2.tag = 0
                       
                       cell2.locoIcon3.tag = 0
                       
                       cell2.locoIcon4.tag = 0
            
            cell2.LogoIcon.backgroundColor = nil
            
             cell2.LogoIcon2.backgroundColor = nil
            
             cell2.LogoIcon3.backgroundColor = nil
            
             cell2.LogoIcon4.backgroundColor = nil
            
            cell2.LogoIcon.image = logoImages[indexPath.row]
            
            cell2.LogoIcon2.image = logoImages2[indexPath.row]
            
            cell2.LogoIcon3.image = logoImages3[indexPath.row]
            
            cell2.LogoIcon4.image = logoImages4[indexPath.row]
                  
            
           if caseNumber == 0{
            
                print(caseNumber)
                
            cell2.locoIcon.tag = indexPath.row
            
            cell2.locoIcon2.tag = indexPath.row
            
            cell2.locoIcon3.tag = indexPath.row
            
            cell2.locoIcon4.tag = indexPath.row
            
            
            cell2.locoIcon.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
               cell2.locoIcon2.addTarget(self, action: #selector(buttonTapped2(_:)), for: .touchUpInside)
            
             cell2.locoIcon3.addTarget(self, action: #selector(buttonTapped3(_:)), for: .touchUpInside)
              
             cell2.locoIcon4.addTarget(self, action: #selector(buttonTapped4(_:)), for: .touchUpInside)
             
            
            }
            
        return cell2
            
        case 1:
        
            caseNumber = 1
        
            cell3.locoIcon.tag = 0
            
            cell3.locoIcon2.tag = 0
            
            cell3.locoIcon3.tag = 0
            
            cell3.locoIcon4.tag = 0
            
            cell3.LogoIcon.image = nil
            
             cell3.LogoIcon2.image = nil
            
             cell3.LogoIcon3.image = nil
            
             cell3.LogoIcon4.image = nil
            
            cell3.LogoIcon.backgroundColor = colorArray1[indexPath.row]
            
            cell3.LogoIcon2.backgroundColor = colorArray2[indexPath.row]
            
            cell3.LogoIcon3.backgroundColor = colorArray3[indexPath.row]
            
            cell3.LogoIcon4.backgroundColor = colorArray4[indexPath.row]
            
            if caseNumber == 1{
                
                print(caseNumber)
            
            cell3.locoIcon.tag = indexPath.row
            
            cell3.locoIcon2.tag = indexPath.row
            
            cell3.locoIcon3.tag = indexPath.row
            
            cell3.locoIcon4.tag = indexPath.row
            
          
            
            cell3.locoIcon.addTarget(self, action: #selector(buttonTapped5(_:)), for: .touchUpInside)
                       
                          cell3.locoIcon2.addTarget(self, action: #selector(buttonTapped6(_:)), for: .touchUpInside)
                       
                        cell3.locoIcon3.addTarget(self, action: #selector(buttonTapped7(_:)), for: .touchUpInside)
                         
                        cell3.locoIcon4.addTarget(self, action: #selector(buttonTapped8(_:)), for: .touchUpInside)
             
         
            }
            return cell3
           
            
        default:
        caseNumber = -1
        return UITableViewCell()
            
        }
        
    }
    
    @objc func buttonTapped(_ sender: UIButton){
        mainlogo.image = logoImages[sender.tag]
        
    }
    
    @objc func buttonTapped2(_ sender: UIButton){
        mainlogo.image = logoImages2[sender.tag]
        
    }
    
    @objc func buttonTapped3(_ sender: UIButton){
          mainlogo.image = logoImages3[sender.tag]
          
      }
    
    @objc func buttonTapped4(_ sender: UIButton){
          mainlogo.image = logoImages4[sender.tag]
          
      }
    
    @objc func buttonTapped5(_ sender: UIButton){
           mainlogo.tintColor = colorArray1[sender.tag]
           
       }
       
       @objc func buttonTapped6(_ sender: UIButton){
           mainlogo.tintColor = colorArray2[sender.tag]
           
       }
       
       @objc func buttonTapped7(_ sender: UIButton){
             mainlogo.tintColor = colorArray3[sender.tag]
             
         }
       
       @objc func buttonTapped8(_ sender: UIButton){
             mainlogo.tintColor = colorArray4[sender.tag]
             
         }

    @IBAction func Change(_ sender: Any) {
        Customtable.reloadData()
    }
    
}

