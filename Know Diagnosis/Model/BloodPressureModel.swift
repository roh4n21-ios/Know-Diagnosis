//
//  TestDataModel.swift
//  Know Diagnosis
//
//  Created by Rohan  on 21/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import Foundation
import RealmSwift

class BloodPressureModel:Object {
    
    @objc dynamic var systolic  : Float    = 0.0
    @objc dynamic var diastolic : Float    = 0.0
    @objc dynamic var condition : String = ""
    @objc dynamic var dateCreated : String = ""

}
