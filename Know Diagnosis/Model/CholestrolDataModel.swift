//
//  CholestrolDataModel.swift
//  Know Diagnosis
//
//  Created by Rohan  on 27/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import Foundation
import RealmSwift

class CholestrolDataModel: Object{
    
    @objc dynamic var totalCholestrol : Float = 0.0
    @objc dynamic var condition : String = ""
    @objc dynamic var dateCreated : String = ""
    
    
}
