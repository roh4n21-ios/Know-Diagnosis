//
//  Result.swift
//  Know Diagnosis
//
//  Created by Rohan  on 21/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import UIKit

class Result: UIViewController {
    
    var condition : String = ""
    var symptoms  : String = ""
    
  
    
    @IBOutlet weak var symptomsLabel: UILabel!
    @IBOutlet weak var DetailLabel: UILabel!
    @IBOutlet weak var TopLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TopLabel.layer.masksToBounds = true
        TopLabel.layer.cornerRadius = 10
        symptomsLabel.layer.masksToBounds = true
        symptomsLabel.layer.cornerRadius = 10
        DetailLabel.layer.masksToBounds = true
        DetailLabel.layer.cornerRadius = 10
        
        TopLabel.text = condition
        sym()
  //      navigationItem.hidesBackButton = true
        
        
    }
    

  
    func sym(){
        
        if symptoms != ""{
            symptomsLabel.isHidden = false
            DetailLabel.isHidden = false
            DetailLabel.text = symptoms

        }
        else{
            DetailLabel.isHidden = true

        }
        
    }

    
  
    
    @IBAction func backButton(_ sender: Any) {

    _ = navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
}
