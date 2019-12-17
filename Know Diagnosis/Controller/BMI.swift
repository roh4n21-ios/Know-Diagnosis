//
//  BMI.swift
//  Know Diagnosis
//
//  Created by Rohan  on 29/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import UIKit
import RealmSwift

class BMI: FunctionController {
    
    
    let realm = try! Realm()
    let dateClass = DateClass()
    var segueParameters:Bool = true
    var condition = ""
    var symptoms  = ""
    var weight : Float = 0.0
    var height : Float = 0.0
    var bmi    : Float = 0.0
    var shortenedBmi :String = ""
    
    
    @IBOutlet var uiView: UIView!

    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var Segment1: UISegmentedControl!
    
    @IBOutlet weak var Segment2: UISegmentedControl!
    
    @IBOutlet weak var getResult: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        weightLabel.layer.masksToBounds = true
        weightLabel.layer.cornerRadius = 10
        heightLabel.layer.masksToBounds = true
        heightLabel.layer.cornerRadius = 10
        getResult.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uiViewTapped))

        uiView.addGestureRecognizer(tapGesture)
        
        
        
        weightTextField.delegate = self
        heightTextField.delegate = self

        weightTextField.keyboardType = .decimalPad
        heightTextField.keyboardType = .decimalPad

    }
    

    @IBAction func SegmentChanged(_ sender: UISegmentedControl) {
        
        if Segment1.selectedSegmentIndex == 0{
            Segment2.selectedSegmentIndex = 0
        }
        else {
            Segment2.selectedSegmentIndex = 1
           
        }
        
    }
    
    @IBAction func Segment2Change(_ sender: UISegmentedControl) {
        
        if Segment2.selectedSegmentIndex == 0{
                  Segment1.selectedSegmentIndex = 0
              }
              else {
                  Segment1.selectedSegmentIndex = 1
                 
              }
              
    }
    
    @objc func uiViewTapped (){
          weightTextField.endEditing(true)
          heightTextField.endEditing(true)
          
      
      }
    
    
    @IBAction func ButtonPressed(_ sender: UIButton) {
       if (weightTextField.text!.isEmpty) || (heightTextField.text!.isEmpty){
                         
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
            if segue.identifier == "bmiIdentifier" {

                let destinationVC = segue.destination  as! Result
                if condition != "Nil"
                 {
                 destinationVC.condition = "Your are " + condition
                 }
                else{
                 destinationVC.condition = "Please re-check Your BMI Index"
                    }
                
                destinationVC.symptoms = symptoms

            }
        }
        

        func getData(){
            
            
            if let wei = weightTextField.text{
                weight = Float(wei) ?? 0
                
            }
            if let hei = heightTextField.text{
                height = Float(hei) ?? 0
                      
                   }
            
          let bmiCalculated = BmiCalculate(Weight:weight, Height:height)
            
            shortenedBmi = String(format: "%.2f",bmiCalculated)
            
        }
        
        func BmiCalculate (Weight:Float,Height:Float)-> Float {
    
             
            
            
            if  Segment1.selectedSegmentIndex == 0{
                 bmi = Weight/pow(Height, 2)
                
                if (bmi >= 18.5 && bmi <= 25.0){
                    condition = "Normal"
                    symptoms = ""
                  }
                else if (bmi > 25.0){
                    condition = "Over Weight"
                    symptoms = ("Breathlessness \n Sweating \n Joint pain \n Lead to Blood Pressure  \n Lead to high cholestrol \n Lead to Cardiovascular Diseases \n Tiredness")
                }
                else if (bmi < 18.5){
                    condition = "Under Weight"
                    symptoms = ("Weak Immune System \n Dizziness \n Fatigue \n Poor Growth \n Hair loss \n Low Anemia \n Fragile bones")
                }
                else{
                    condition = "Nil"
                    symptoms = ""
                }
                
            }
            else{
                 bmi = (Weight/pow(Height,2) * 703)
                if (bmi >= 18.5 && bmi <= 25.0){
                       condition = "Normal"
                       symptoms = ""
                   }
                else if (bmi > 25.0){
                       condition = "Over Weight"
                       symptoms = ("Breathlessness \n Sweating \n Joint pain \n Lead to Blood Pressure  \n Lead to high cholestrol \n Lead to Cardiovascular Diseases \n Tiredness")
                   }
                   else if  (bmi < 18.5){
                       condition = "Under Weight"
                       symptoms = ("Weak Immune System \n Dizziness \n Fatigue \n Poor Growth \n Hair loss \n Low Anemia \n Fragile bones")
                   }
                   else{
                       condition = "Nil"
                       symptoms = ""
                   }
              
            }
            
    
            return bmi
    
    }

         
        func saveData(){
            
            if condition != "Nil"
            {
            do{
          
                try realm.write {
                    let bmModel   = BmiDataModel()
                    bmModel.condition = condition
                    bmModel.Bmi  = shortenedBmi
                    bmModel.dateCreated = dateClass.currentDate()

                    realm.add(bmModel)
                }
                
            } catch{
                
                print("Error in initialising new realm,\(error)")
            }
            }else{}
        }
           
    
    
    
    
}
