//
//  CustomCell.swift
//  Know Diagnosis
//
//  Created by Rohan  on 24/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//


import UIKit

class CustomCell:UITableViewCell {
  

    @IBOutlet weak var condition: UILabel!
    
    @IBOutlet weak var testtype1: UILabel!
    
    @IBOutlet weak var testtype1value: UILabel!
    
    @IBOutlet weak var testtype2: UILabel!
    
    @IBOutlet weak var testtype2value: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var testtype3: UILabel!
    
    @IBOutlet weak var testtype3value: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        condition.layer.masksToBounds = true
        condition.layer.cornerRadius = 10
    }
    
   
   
    
    
}
