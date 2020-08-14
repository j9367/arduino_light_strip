//
//  History.swift
//  Light control
//
//  Created by Vasilis Michalakis on 27/6/20.
//  Copyright © 2020 Vasilis Michalakis. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell{
    @IBOutlet weak var Symbol: UIImageView!
    @IBOutlet weak var mainEvent: UILabel!
    
    @IBOutlet weak var userProfile: UILabel!

    @IBOutlet weak var timeInitiated: UILabel!
    
}

 let cellReuseIdentifier = "cell"

class History: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.Table.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        Table.delegate = self
        Table.dataSource = self
        
       
        
        if HistoryState == "on"{
            Image.isHidden = true
            Label.isHidden = true
            Table.isHidden = false
            if reverseButtonHistory.count == 0 {
                Image.image = UIImage(systemName: "arrow.counterclockwise")
                Image.isHidden = false
                 Label.text = "No History to Display"
                Label.center.x = self.view.center.x
                 Label.center.y = self.view.center.y
                Label.isHidden = false
                Table.isHidden = true
            }
            
            else{
              Image.isHidden = true
                Label.isHidden = true
                Table.isHidden = false
            }
        }
        else {
            
            Image.image = UIImage(systemName: "arrow.counterclockwise.icloud.fill")
            Image.isHidden = false
            Label.text = "Enable History in Settings"
            Label.isHidden = false
            Table.isHidden = true
        }
        
        
        
        self.Table.rowHeight = 103.0
        // Do any additional setup after loading the view.
     
    }
    
    @IBOutlet var Blocker: UIView!
    
    @IBOutlet var Image: UIImageView!
    
    @IBOutlet var Label: UILabel!
    
    @IBOutlet weak var Table: UITableView!
    
    @IBOutlet weak var Delete: UIButton!
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reverseButtonHistory.count
      
    }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "Hcell") as! HistoryCell

    cell.mainEvent.text = reverseButtonHistory[indexPath.row]
    cell.userProfile.text = "User Initiated: \(profileName)"
    currentDateTime = Date()
    cell.timeInitiated.text = reverseTimeButtonHistory[indexPath.row]
       
    if reverseButtonHistory[indexPath.row] == "Rainbow"{
        cell.Symbol.image = UIImage(systemName: "rays")
        cell.Symbol.tintColor = UIColor.gray
    }
    
    if reverseButtonHistory[indexPath.row] == "Strobe"{
        cell.Symbol.image = UIImage(systemName: "circle.lefthalf.fill")
        cell.Symbol.tintColor = UIColor.gray
    }
    
    if reverseButtonHistory[indexPath.row] == "Police"{
        cell.Symbol.image = UIImage(systemName: "circle.righthalf.fill")
        cell.Symbol.tintColor = UIColor.gray
    }
    
    if reverseButtonHistory[indexPath.row] == "Red"{
           cell.Symbol.image = UIImage(systemName: "circle")
           cell.Symbol.tintColor = UIColor.red
       }
    
    if reverseButtonHistory[indexPath.row] == "Green"{
              cell.Symbol.image = UIImage(systemName: "circle")
              cell.Symbol.tintColor = UIColor.green
          }
    
    if reverseButtonHistory[indexPath.row] == "Blue"{
                 cell.Symbol.image = UIImage(systemName: "circle")
                 cell.Symbol.tintColor = UIColor.blue
             }
    
    if reverseButtonHistory[indexPath.row] == "Off"{
                 cell.Symbol.image = UIImage(systemName: "circle")
                 cell.Symbol.tintColor = UIColor.gray
             }
    
    
    
    return cell
   }
   
   
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func RemoveData(_ sender: Any) {
        buttonHistory.removeAll()
        reverseButtonHistory.removeAll()
        timeButtomHistory.removeAll()
        reverseTimeButtonHistory.removeAll()
        defaults.set(buttonHistory, forKey: "buttonHistory")
        defaults.set(timeButtomHistory, forKey: "timeButtomHistory")
        Table.reloadData()
    }
    
    
}
