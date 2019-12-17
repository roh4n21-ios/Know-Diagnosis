//
//  Cholestrol.swift
//  Know Diagnosis
//
//  Created by Rohan  on 27/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import UIKit
import RealmSwift

class Cholestrol: FunctionController {
    
    let realm = try! Realm()
    let dateClass = DateClass()
    var segueParameters:Bool = true
    var Symptoms  = ""
    var condition = ""
    var totalCholestrol :Float = 0.0
    
    @IBOutlet var uiView: UIView!

    @IBOutlet weak var totalCholestrolLabel: UILabel!
    
    @IBOutlet weak var TCHTextField: UITextField!
    
    @IBOutlet weak var GetResult: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        totalCholestrolLabel.layer.masksToBounds = true
        totalCholestrolLabel.layer.cornerRadius = 10
                      
         GetResult.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uiViewTapped))

         uiView.addGestureRecognizer(tapGesture)
        
        TCHTextField.delegate = self
        TCHTextField.keyboardType = .decimalPad
        
    }
    

   
    @IBAction func buttonPressed(_ sender: UIButton) {
       if (TCHTextField.text!.isEmpty)
       {
              segueParameters = false
                            }
                            
                     else{
                     getData()
                     saveData()
                     segueParameters = true
                     }
        
    }
    
    @objc func uiViewTapped (){
          TCHTextField.endEditing(true)
          
      
      }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if segueParameters ==  false{
             
             return false
        }
        
        return true
    
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "cHIdentifier" {

            let destinationVC = segue.destination  as! Result
                if condition != "Nil"
                {
                destinationVC.condition = "Your Cholestrol Level is " + condition
                }
               else{
                destinationVC.condition = "Please re-check Your Cholestrol Level"
                   }
      
                destinationVC.symptoms = Symptoms

            }
        }
        

        func getData(){
            
            
            if let TCH = TCHTextField.text{
                totalCholestrol = Float(TCH) ?? 0
                
            }
           
            let result =  calculation(tch:totalCholestrol)
            
            condition         =  result.0
            Symptoms          =  result.1
            
        }
        
        
        
        
        func calculation (tch:Float) -> (String,String){
     
            if (tch < 200.0)
            {
            
                return ( "Normal", "")
                
            }
            
            
            else if  (tch >= 200.0 && tch <= 239.0)
            {
        
            return  ( "Slightly High", "Chest Pain \n HeartAttack \n Stroke \n Blocked Arteries")
            }

            
                
            else if (tch >= 240.0)
            {

             return  ("High","Chest Pain \n HeartAttack \n Stroke \n Blocked Arteries")
                         
            }

     
        else
            {
                
                return ("Nil","")
             }



    }
    
    func saveData(){
        
        if condition != "Nil"
        {
        do{
            
                   try realm.write {
                    let cHModel   = CholestrolDataModel()
                    cHModel.condition = condition
                    cHModel.totalCholestrol = totalCholestrol
                    cHModel.dateCreated = dateClass.currentDate()

                    realm.add(cHModel)
                    
                   }
                  
               } catch{
                   
                   print("Error in initialising new realm,\(error)")
               }
        }else{}
        
    }

    
    
}
