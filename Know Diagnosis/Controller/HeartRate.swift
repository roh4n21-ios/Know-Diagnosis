//
//  HeartRate.swift
//  Know Diagnosis
//
//  Created by Rohan  on 14/10/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import UIKit
import RealmSwift

class HeartRate: FunctionController {

    let realm = try! Realm()
    let dateClass = DateClass()
    var segueParameters:Bool = true
    var condition = ""
    var Symptoms  = ""
    var typeName = ""
    var heartRateLevel:Int = 0
    var Age :Int = 0
 
    @IBOutlet var uiView: UIView!
    
    @IBOutlet weak var Segment: UISegmentedControl!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var yrsLabel: UILabel!
    
    @IBOutlet weak var heartRateLabel: UILabel!
       
    @IBOutlet weak var heartRateTextField: UITextField!
    
    @IBOutlet weak var GetResult: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       ageLabel.layer.masksToBounds = true
       ageLabel.layer.cornerRadius = 10
       heartRateLabel.layer.masksToBounds = true
       heartRateLabel.layer.cornerRadius = 10
       GetResult.layer.cornerRadius = 10
       
       
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uiViewTapped))

             uiView.addGestureRecognizer(tapGesture)
       
       ageTextField.delegate = self
       heartRateTextField.delegate = self
        ageTextField.keyboardType = .numberPad
        heartRateTextField.keyboardType = .numberPad
        
        ageLabel.isHidden = true
        ageTextField.isHidden = true
        yrsLabel.isHidden = true
    }
    

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
       if Segment.selectedSegmentIndex == 0{
            
            ageLabel.isHidden = true
            ageTextField.isHidden = true
            yrsLabel.isHidden = true
            
        }
       else{
        ageLabel.isHidden = false
        ageTextField.isHidden = false
        yrsLabel.isHidden = false
        }
        
    }
    @IBAction func ButtonPressed(_ sender: UIButton) {
         
        if Segment.selectedSegmentIndex != 0{
         if (ageTextField.text!.isEmpty) || (heartRateTextField.text!.isEmpty){
       
        segueParameters = false
            }
         else if (Int(ageTextField.text!)! < 20){
            
            ageTextField.text = nil
            heartRateTextField.text = nil
            segueParameters = false
         }
  

        else {
        getData()
        saveData()
        segueParameters = true
        }
        }
            
        else{
            if (heartRateTextField.text!.isEmpty){
            segueParameters = false
                 }
                 else{
                 getData()
                 saveData()
                 segueParameters = true
                 }
            
        }
            
              
       
   }
        @objc func uiViewTapped (){
              ageTextField.endEditing(true)
              heartRateTextField.endEditing(true)
          
          }
        override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            if segueParameters ==  false{
                 
                 return false
            }
            
            return true
        
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "heartRateIdentifier" {
                let destinationVC = segue.destination  as! Result
                if condition != "Nil"{
                destinationVC.condition = "Your HeartRate is " + condition
                 }
                else{
                    destinationVC.condition = "Please re-check Your HeartRate"
                }

                destinationVC.symptoms = Symptoms

            }
        }
        

        func getData(){
            
            
            if let hRLevel = heartRateTextField.text{
                heartRateLevel = Int(hRLevel) ?? 0
                
            }
            if let age = ageTextField.text{
                   Age = Int(age) ?? 0
            
                                     
            }
            
        let result =  calculation(HeartRateLevel : heartRateLevel)
            
            condition         =  result.0
            Symptoms          =  result.1
            
        }
        
        
        
        
    func calculation (HeartRateLevel:Int) -> (String,String){
     
            if (Segment.selectedSegmentIndex == 0)
            {
                
                
                typeName = "Resting State"
                
                if (HeartRateLevel >= 60) && (HeartRateLevel <= 100){
                    
                 return ( "Normal", "")
                    
                }
                    
                else if (HeartRateLevel > 100){
                
                return ( " High", " Rapid heartbeat \n Dizziness \n Shortness of breath \n Chest pain \n Fainting \n Fatigue \n Unconsciousness ")
                    
                }
                    
               else if (HeartRateLevel < 60){
               
               return ( " Low", "  Dizziness \n Shortness of breath \n Fainting \n Fatigue  ")
                   
               }
                    
                
                else
                {
                    return ("Nil","")
                 }
                
                
                }
                
                
            
            
            
        else if (Segment.selectedSegmentIndex == 1)
             {
                
                typeName = "Active State"
                
                let ActiveHeartRateLevel = (220 - Age)
                
                if (HeartRateLevel <= ActiveHeartRateLevel)
                && (HeartRateLevel >= 60)
                {
                     
                  return ( "Normal", "")
                     
                 }
                     
                
                     
                else if (HeartRateLevel > ActiveHeartRateLevel){
                 
                 return ( " High", " Rapid heartbeat \n Dizziness \n Shortness of breath \n Chest pain \n Fainting \n Fatigue \n Unconsciousness \n  Bleeding \n Heart attack \n Heart failure \n Cardiac arrest ")
                    
                 }
                    
                else if (HeartRateLevel < 60){
                              
                  return ( " Low", "  Dizziness \n Shortness of breath \n Fainting \n Fatigue ")
                                  
                              }
                else
                {
                    return ("Nil","")
                 }
                 
                 
                 }
                 
      
     
          else
            {
              typeName = ""
                return ("Nil","")
             }


             
    }
                
             func saveData(){
                    
                    if condition != "Nil"
                    {
                    do{
                 
                try realm.write {
                let hRModel  = HeartRateDataModel()
                    hRModel.condition = condition
                    hRModel.heartRateLevel = heartRateLevel
                    hRModel.name = typeName
                    hRModel.dateCreated = dateClass.currentDate()
                    realm.add(hRModel)
                                
                               }
                              
                   } catch{
                       
                       print("Error in initialising new realm,\(error)")
                   }
                }else{}

        }

}
