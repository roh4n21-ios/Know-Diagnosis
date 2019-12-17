//
//  ViewController.swift
//  Know Diagnosis
//
//  Created by Rohan  on 21/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
      @IBOutlet weak var BloodPressure: UIButton!
    
      @IBOutlet weak var Diabetes: UIButton!
    
      @IBOutlet weak var Cholestrol: UIButton!
    
      @IBOutlet weak var Fever: UIButton!
    
      @IBOutlet weak var BmiIndex: UIButton!
    
      @IBOutlet weak var Dengue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BloodPressure.layer.cornerRadius = 10
        Diabetes.layer.cornerRadius = 10
        Cholestrol.layer.cornerRadius = 10
        Fever.layer.cornerRadius = 10
        BmiIndex.layer.cornerRadius = 10
        Dengue.layer.cornerRadius = 10
        
        

    }
    
    
   

}
