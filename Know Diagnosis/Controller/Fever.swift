//
//  Fever.swift
//  Know Diagnosis
//
//  Created by Rohan  on 27/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import UIKit
import RealmSwift

class Fever: FunctionController {
    
    let realm = try! Realm()
    let dateClass = DateClass()
    var segueParameters:Bool = true
    var Symptoms  = ""
    var condition = ""
    var Flevel:Float = 0.0
    var feverLevel = ""
    
    @IBOutlet var uiView: UIView!

    @IBOutlet weak var feverLabel: UILabel!
    @IBOutlet weak var feverTextField: UITextField!
    @IBOutlet weak var GetResult: UIButton!
    @IBOutlet weak var Segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

          feverLabel.layer.masksToBounds = true
          feverLabel.layer.cornerRadius = 10
                      
          GetResult.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uiViewTapped))

               uiView.addGestureRecognizer(tapGesture)
        
        
        feverTextField.delegate = self
        feverTextField.keyboardType = .decimalPad
        
        
    }
    

    
    
    @IBAction func ButtonPressed(_ sender: UIButton) {
        
        if (feverTextField.text!.isEmpty)
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
             feverTextField.endEditing(true)
         
         }
       
    

        func getData(){
            
            
            if let FeverLevel = feverTextField.text{
                Flevel = Float(FeverLevel) ?? 0
                
            }
            
            let result =  calculation(FeverLevel : Flevel)
            
            condition         =  result.0
            Symptoms          =  result.1
            
            
        }
        
        
        
        
        func calculation (FeverLevel:Float) -> (String,String){
     
            if (Segment.selectedSegmentIndex == 0)
            {
               feverLevel = String(FeverLevel) + "°F"
               
                if (FeverLevel >= 98.6) && (FeverLevel <= 100.4){
                    
                 return ( "Normal", "")
                    
                }
                    
                else if (FeverLevel > 100.4){
                
                return ( "High", "Sweating \n Chills and shivering\n Headache \n Muscle aches \n Loss of appetite \n Irritability \n Dehydration \n weakness")
                    
                }
                else{
                    
                    return("Nil","")
                }
                    
                
                
                }
                

            
        else if (Segment.selectedSegmentIndex == 1)
             {
                
                feverLevel = String(FeverLevel) + "°C"
                if (FeverLevel >= 36.0) && (FeverLevel <= 38.0){
                     
                  return ( "Normal", "")
                     
                 }
                     
                else if (FeverLevel > 38.0)  {
                 
                 return ( "High", "Sweating \n Chills and shivering\n Headache \n Muscle aches \n Loss of appetite \n Irritability \n Dehydration \n weakness")
                     
                 }
                
                else{
                return("Nil","")
                    }
                 
                 
                 }

     
          else
            {
                return ("Nil","")
             }

             
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if segueParameters ==  false{
             
             return false
        }
        
        return true
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "feverIdentifier" {

                let destinationVC = segue.destination  as! Result
                if condition != "Nil"
                 {
                    if condition == "Normal"{
                 destinationVC.condition = "Your Body Temperature is " + condition
                    }
                    else{
                        
                     destinationVC.condition = "You Have a Fever"
                    }
                 }
                else{
                 destinationVC.condition = "Please re-check Temperature Level"
                    }
                
                destinationVC.symptoms = Symptoms
            }
        }
    
    
    func saveData(){
        
        if condition != "Nil"
        {
        do{
            
                   
                   try realm.write {
                    let fRModel   = FeverDataModel()
                    fRModel.condition = condition
                    fRModel.feverLevel = feverLevel
                    fRModel.dateCreated = dateClass.currentDate()

                    realm.add(fRModel)
                    
                   }
                  
               } catch{
                   
                   print("Error in initialising new realm,\(error)")
               }
        }else{}
        
    }
        

}
