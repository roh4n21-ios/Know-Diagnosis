//
//  BmiDataModel.swift
//  Know Diagnosis
//
//  Created by Rohan  on 29/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import Foundation
import RealmSwift

class BmiDataModel:Object {
    
    @objc dynamic var Bmi       : String  = ""
    @objc dynamic var condition : String = ""
    @objc dynamic var dateCreated : String = ""
     

}
