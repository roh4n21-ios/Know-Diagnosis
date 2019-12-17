//
//  AppDelegate.swift
//  Know Diagnosis
//
//  Created by Rohan  on 18/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do{
            
          _ = try Realm()
            
        }
        catch{
            print("Error in initialising new realm,\(error)")
        }
        
        
        
        return true
        
        
    }

  

}

