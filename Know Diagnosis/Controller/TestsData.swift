//
//  TestsData.swift
//  Know Diagnosis
//
//  Created by Rohan  on 23/09/19.
//  Copyright © 2019 Rohan . All rights reserved.

import UIKit
import RealmSwift
import SwipeCellKit

class TestsData:SwipeTableViewController{


    let realm            = try! Realm()
    var selectedCategory = ""
    var index            = 0
    var data             : Results<Object>!
    let dataArray        = [BloodPressureModel.self,DiabetesDataModel.self,CholestrolDataModel.self,FeverDataModel.self,BmiDataModel.self,HeartRateDataModel.self]
    
    @IBOutlet var dataTableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTableView.dataSource = self
        dataTableView.delegate   = self
        

    tableView.register(UINib(nibName: "DisplayCell", bundle: nil), forCellReuseIdentifier: "customcell")
        
        //configureTableView()

        navigationItem.title = selectedCategory
        
        
        loadData(Index:index)
        
        tableView.reloadData()
    }
    
    func loadData(Index:Int){
        
        data = realm.objects(dataArray[index]).sorted(byKeyPath: "dateCreated", ascending: false)
         tableView.reloadData()
        
        
        }
    

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
    
     return data.count
        
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! CustomCell
       
      
    if selectedCategory == "BloodPressure"
    {
        if let data = data?[indexPath.row]{
        
        cell.condition.text =  data.value(forKey:   "condition") as? String


        cell.testtype1.text = "Systolic"

        cell.testtype1value.text = String(data.value(forKey: "systolic") as! Float)

        cell.testtype2.text = "Diastolic"
        cell.testtype2value.text = String(data.value(forKey: "diastolic") as! Float)

            cell.dateLabel.text = (data.value(forKey: "dateCreated") as! String)
        }

        }
     else if selectedCategory == "Diabetes"
        {
            if let data = data?[indexPath.row]{

            cell.condition.text = data.value(forKey: "condition") as? String

            cell.testtype3.text = data.value(forKey: "name") as? String

            cell.testtype3value.text = String(data.value(forKey: "diabetesLevel") as! Float)
            cell.dateLabel.text = (data.value(forKey: "dateCreated") as! String)

            }
            }


      else if selectedCategory == "Cholestrol"
        {
            if let data = data?[indexPath.row]{

            cell.condition.text = data.value(forKey: "condition") as? String

            cell.testtype3.text = "Cholestrol"


            cell.testtype3value.text = String(data.value(forKey: "totalCholestrol") as! Float)
                
            cell.dateLabel.text = (data.value(forKey: "dateCreated") as! String)

            }
            }

        else if selectedCategory == "Fever"
               {
                if let data = data?[indexPath.row]{

               cell.condition.text = data.value(forKey: "condition") as? String

               cell.testtype3.text = "Fever Level"


               cell.testtype3value.text = String(data.value(forKey: "feverLevel") as! String)

                cell.dateLabel.text = (data.value(forKey: "dateCreated") as! String)
               }
    }
        else if selectedCategory == "BMI Index"
        {
       if let data = data?[indexPath.row]{
        cell.condition.text = data.value(forKey: "condition") as? String

        cell.testtype3.text = "BMI"


        cell.testtype3value.text = String(data.value(forKey: "Bmi") as! String)
        
        cell.dateLabel.text = (data.value(forKey: "dateCreated") as! String)

        }
    }

        else{
              if let data = data?[indexPath.row]{

              cell.condition.text = data.value(forKey: "condition") as? String

              cell.testtype3.text = data.value(forKey: "name") as? String

              cell.testtype3value.text = String(data.value(forKey: "heartRateLevel") as! Int)
              cell.dateLabel.text = (data.value(forKey: "dateCreated") as! String)

              }
                  

        
        }
        
        return cell
    }
    
 
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//         super.tableView(tableView, cellForRowAt: indexPath)
        
        deleteData(indexPath: indexPath)
        
    }
    
    
    func deleteData(indexPath:IndexPath){
        
        if let item = data?[indexPath.row] {
                  
                     do {
                         try realm.write {
                             realm.delete(item)
                         }
                     } catch {
                         print("Error deleting Item, \(error)")
                     }
                 }
        tableView.reloadData()
        
    }
       
    
    
//    func configureTableView(){
//
//        dataTableView.rowHeight = UITableView.automaticDimension
//        dataTableView.estimatedRowHeight = 80.0
//
//    }
//
 

}

