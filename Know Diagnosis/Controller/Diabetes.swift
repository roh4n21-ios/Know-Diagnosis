//
//  Diabetes.swift
//  Know Diagnosis
//
//  Created by Rohan  on 25/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import UIKit
import RealmSwift

class Diabetes: FunctionController {
    
    let realm = try! Realm()
    let dateClass = DateClass()
    var segueParameters:Bool = true
    var condition = ""
    var Symptoms  = ""
    var typeName = ""
    var diabetesLevel:Float = 0.0
    
    @IBOutlet var uiView: UIView!
    
    @IBOutlet weak var Segment: UISegmentedControl!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var value: UITextField!
    
    @IBOutlet weak var GetResult: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

               nameLabel.layer.masksToBounds = true
               nameLabel.layer.cornerRadius = 10
               
               GetResult.layer.cornerRadius = 10
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uiViewTapped))

              uiView.addGestureRecognizer(tapGesture)
        
        value.delegate = self
        value.keyboardType = .numberPad

        
    }
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
          
         if Segment.selectedSegmentIndex == 1{
              
            nameLabel.text = "After Food"
              
          }
         else if Segment.selectedSegmentIndex == 2{
          nameLabel.text = "Random"
          }
         else{
            nameLabel.text = "Fasting"
            
        }
      }
    
  
    
    
    @IBAction func ButtonPressed(_ sender: UIButton) {
        
        if (value.text!.isEmpty){
        segueParameters = false
                      }
                      
               else{
               getData()
               saveData()
               segueParameters = true
               }
        
    }
    
    
    @objc func uiViewTapped (){
          value.endEditing(true)
          
      
      }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if segueParameters ==  false{
             
             return false
        }
        
        return true
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "diabetesIdentifier" {
            let destinationVC = segue.destination  as! Result
            if condition != "Nil"{
            destinationVC.condition = "Your Diabetes is " + condition
             }
            else{
                destinationVC.condition = "Please re-check Your Diabetes"
            }

            destinationVC.symptoms = Symptoms

        }
    }
    

    func getData(){
        
        
        if let dbLevel = value.text{
            diabetesLevel = Float(dbLevel) ?? 0
            
        }
        
        let result =  calculation(DiabetesLevel : diabetesLevel)
        
        condition         =  result.0
        Symptoms          =  result.1
        
    }
    
    
    
    
    func calculation (DiabetesLevel:Float) -> (String,String){
 
        if (Segment.selectedSegmentIndex == 0)
        {
            typeName = "Fasting"
            
            if (DiabetesLevel >= 70.0) && (DiabetesLevel <= 100.0){
                
             return ( "Normal", "")
                
            }
                
            else if (DiabetesLevel >= 100.0 && DiabetesLevel <= 125.0){
            
            return ( "Slightly High", "Frequent Urination \n Thirst \n Fatigue \n Nausea & Vomiting \n Shortness of Breath \n Stomach Pain \n Rapid HeartBeat")
                
            }
                
            else if (DiabetesLevel >= 126.0 ){
            
            return ( "High", "Frequent Urination \n Thirst \n Fatigue \n Nausea & Vomiting \n Shortness of Breath \n Stomach Pain \n Rapid HeartBeat")
            }
                
            else if (DiabetesLevel < 70.0){
                 
              return ( "Low", "Blurred Vision \n Headache \n Fatigue \n Shaking \n Hunger \n Sweating \n Rapid HeartBeat \n Loss of Consciousness \n Dizziness")
                 
             }
            else
            {
                return ("Nil","")
             }
            
            
            }
            
            
        
        
        
    else if (Segment.selectedSegmentIndex == 1)
         {
            typeName = "After Food"
            
            if (DiabetesLevel >= 70.0 && DiabetesLevel <= 140.0 ){
                 
              return ( "Normal", "")
                 
             }
                 
            else if (DiabetesLevel >= 140.0 && DiabetesLevel <= 199.0){
             
             return ( "Slightly High", "Frequent Urination \n Thirst \n Fatigue \n Nausea & Vomiting \n Shortness of Breath \n Stomach Pain \n Rapid HeartBeat ")
                 
             }
                 
            else if (DiabetesLevel >= 200.0){
             
             return ( "High", "Frequent Urination \n Thirst \n Fatigue \n Nausea & Vomiting \n Shortness of Breath \n Stomach Pain \n Rapid HeartBeat")
                
             }
            else if (DiabetesLevel < 70.0){
                
              return ( "Low", "Blurred Vision \n Headache \n Fatigue \n Shaking \n Hunger \n Sweating \n Rapid HeartBeat \n Loss of Consciousness \n Dizziness")
                
            }
            else
            {
                return ("Nil","")
             }
             
             
             }
             
        
    else if (Segment.selectedSegmentIndex == 2)
         {
             typeName = "Random"
            
            if (DiabetesLevel >= 70.0) && (DiabetesLevel < 200.0){
                 
              return ( "Normal", "")
                 
             }
                 
           
                 
            else if (DiabetesLevel >= 200.0){
             
             return ( "High", "Frequent Urination \n Thirst \n Fatigue \n Nausea & Vomiting \n Shortness of Breath \n Stomach Pain \n Rapid HeartBeat")
             }
            else if (DiabetesLevel < 70.0){
                
              return ( "Low", "Blurred Vision \n Headache \n Fatigue \n Shaking \n Hunger \n Sweating \n Rapid HeartBeat \n Loss of Consciousness \n Dizziness")
                
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
            let dBModel  = DiabetesDataModel()
                dBModel.condition = condition
                dBModel.diabetesLevel = diabetesLevel
                dBModel.name = typeName
                dBModel.dateCreated = dateClass.currentDate()
                realm.add(dBModel)
                            
                           }
                          
               } catch{
                   
                   print("Error in initialising new realm,\(error)")
               }
            }else{}

    }
    
    
    
    
}
