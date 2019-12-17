//
//  FeverDataModel.swift
//  Know Diagnosis
//
//  Created by Rohan  on 27/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import Foundation
import  RealmSwift

class FeverDataModel: Object{
    
    @objc dynamic var feverLevel : String = ""
    @objc dynamic var condition : String = ""
    @objc dynamic var dateCreated : String = ""
    
    
}
