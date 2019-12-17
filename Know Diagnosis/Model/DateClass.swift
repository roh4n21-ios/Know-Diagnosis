//
//  DateClass.swift
//  Know Diagnosis
//
//  Created by Rohan  on 09/10/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import Foundation

class DateClass{
    
    func currentDate()->String{
            let date = Date()
            let Formatter = DateFormatter()
        
               Formatter.dateFormat = "MM-dd-yy HH:mm"
               
               let dateString = Formatter.string(from: date)
        return dateString
    }
    
           
}
