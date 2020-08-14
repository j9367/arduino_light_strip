//
//  TableCustomChooser.swift
//  Light control
//
//  Created by Vasilis Michalakis on 31/7/20.
//  Copyright © 2020 Vasilis Michalakis. All rights reserved.
//

import UIKit



class TVC: UITableViewCell{
        
    @IBOutlet weak var TableLabel: UILabel!
    
    @IBOutlet weak var TableImage: UIImageView!
    
    @IBOutlet weak var TableImage2: UIImageView!
    
    @IBOutlet weak var TabeLabel2: UILabel!
    
    
}



class TableCustomChooser: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
     let cellReuseIdentifier = "cell4"
    

    @IBOutlet var TableQueueChooser: UITableView!
    
    override func viewDidLoad() {
          NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        super.viewDidLoad()
       TableQueueChooser!.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
       TableQueueChooser.delegate = self
        
       TableQueueChooser.dataSource = self
        
        TableQueueChooser!.rowHeight = 150.0
        
       self.TableQueueChooser.separatorStyle = UITableViewCell.SeparatorStyle.none
         
    }
    
   
    
    @objc func loadList(notification: NSNotification){
        //load data here
        self.TableQueueChooser.reloadData()
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        return ReversenameString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell4 = TableQueueChooser!.dequeueReusableCell(withIdentifier: "Chooser") as! TVC
        
        cell4.selectionStyle = .none
        
        cell4.TableLabel.text = ReversenameString[indexPath.row]
        
        cell4.TableImage.image = ReverseimageString[indexPath.row]
        
        cell4.TableImage.tintColor = reverseColorString[indexPath.row]
        
        return cell4
    }
    
   
    
    
   
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
