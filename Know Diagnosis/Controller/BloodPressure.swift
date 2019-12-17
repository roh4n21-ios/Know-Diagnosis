//
//  BloodPressure.swift
//  Know Diagnosis
//
//  Created by Rohan  on 21/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import UIKit
import RealmSwift

class BloodPressure: FunctionController {
    
      let realm = try! Realm()
      let dateClass = DateClass()
      var condition = ""
      var Symptoms  = ""
      var systolic  : Float = 0.0
      var diastolic : Float = 0.0
      var segueParameters:Bool = true

      
    
    @IBOutlet var uiView: UIView!
    @IBOutlet weak var systolicLabel: UILabel!
    @IBOutlet weak var diastolicLabel: UILabel!
    @IBOutlet weak var systolicTextField: UITextField!
    @IBOutlet weak var diastolicTextField: UITextField!
    @IBOutlet weak var GetResult: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        systolicLabel.layer.masksToBounds = true
        systolicLabel.layer.cornerRadius = 10
        diastolicLabel.layer.masksToBounds = true
        diastolicLabel.layer.cornerRadius = 10
        GetResult.layer.cornerRadius = 10
      
        systolicTextField.delegate = self
        diastolicTextField.delegate = self
        systolicTextField.keyboardType = .numberPad
        diastolicTextField.keyboardType = .numberPad
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uiViewTapped))

        uiView.addGestureRecognizer(tapGesture)
       
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
       
        if (systolicTextField.text!.isEmpty) || (diastolicTextField.text!.isEmpty){
                    
                segueParameters = false
               }
               
        else{
        getData()
        saveData()
        segueParameters = true
        }
    }
    
  
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if segueParameters ==  false{
             
             return false
        }
        
        return true
    
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {


        if segue.identifier == "BpIdentifier" {

            let destinationVC = segue.destination  as! Result
            if condition != "Nil"{
                destinationVC.condition = "Your BloodPressure is " + condition}
            else{
                destinationVC.condition = "Please re-check Your BLood Pressure"
            }
            destinationVC.symptoms = Symptoms

            }

    }
    
    
     @objc  func uiViewTapped (){
        systolicTextField.endEditing(true)
        diastolicTextField.endEditing(true)
    
    }
 
    
    
    
    func getData(){
        
        
        if let sys = systolicTextField.text{
            systolic = Float(sys) ?? 0
            
        }
        if let dia = diastolicTextField.text{
            diastolic = Float(dia) ?? 0
                  
               }
            

        
        let result =  calculation(systolic:systolic, diastolic:diastolic)
        
        condition         =  result.0
        Symptoms          =  result.1
        
    }
    
    
    
    
    func calculation (systolic:Float,diastolic:Float) -> (String,String){
        
        if (systolic >= 90.0 && systolic <= 120.0) && (diastolic >= 60.0 && diastolic <= 80.0)
        {
        
            return ( "Normal", "")
            
        }
        
        
        else if  (systolic >= 40.0 && systolic <= 90.0) && (diastolic >= 30.0  && diastolic <= 60.0)
        {
    
        return  ( "Low", "fainting \n shortness of breath \n dizziness \n blurred vision \n nausea & vomiting \n fatigue")
        }

        
        else if (systolic >= 121.0 && systolic <= 129.0) && (diastolic <= 80.0)
        {
      
      return ("Slightly Elevated", "")
   
        }
        else if (systolic >= 130.0 && systolic <= 149.0) && (diastolic <= 89.0)
         {
       
       return ("Slightly High", "Headache \n shortness of breath \n dizziness \n blurred vision \n nausea & vomiting \n Lead to high Blood Pressure ")
    
         }
        
        else if (systolic >= 150.0) || (diastolic >= 90.0)
        {

         return  ("High", "Headache \n shortness of breath \n dizziness \n blurred vision \n nausea & vomiting ")
            
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
                let bPModel   = BloodPressureModel()
                bPModel.condition = condition
                bPModel.systolic  = systolic
                bPModel.diastolic = diastolic
                bPModel.dateCreated = dateClass.currentDate()
                realm.add(bPModel)
            }
            
        } catch{
            
            print("Error in initialising new realm,\(error)")
        }
        }
        else{}
    }
       
        

    
    
    

}
