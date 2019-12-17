//
//  HeartRateDataModel.swift
//  Know Diagnosis
//
//  Created by Rohan  on 14/10/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import Foundation
import RealmSwift

class HeartRateDataModel: Object{
    
    @objc dynamic var heartRateLevel : Int = 0
    @objc dynamic var condition : String = ""
    @objc dynamic var name : String = ""
    @objc dynamic var dateCreated : String = ""
    
}
