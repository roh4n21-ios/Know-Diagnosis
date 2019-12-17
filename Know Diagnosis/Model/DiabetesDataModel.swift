//
//  DiabetesDataModel.swift
//  Know Diagnosis
//
//  Created by Rohan  on 25/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import Foundation
import RealmSwift

class DiabetesDataModel: Object{
    
    @objc dynamic var diabetesLevel : Float = 0.0
    @objc dynamic var condition : String = ""
    @objc dynamic var name : String = ""
    @objc dynamic var dateCreated : String = ""
    
}
