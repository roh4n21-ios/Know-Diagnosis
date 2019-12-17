//
//  HealthDataViewController.swift
//  Know Diagnosis
//
//  Created by Rohan  on 23/09/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import UIKit

class HealthDataViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var categories = Category ()
    
    
    @IBOutlet weak var DataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataTableView.delegate = self
        DataTableView.dataSource = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.categoryArray.count
       }
    

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell =  tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        
        let item = categories.categoryArray[indexPath.row]
        
        cell.textLabel?.text = item
        
        
        return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    
    
   
    override func prepare(for segue: UIStoryboardSegue , sender: Any?) {
         
        if segue.identifier == "goToData"{
        
           let destinationVc = segue.destination as! TestsData
        
            if let indexPath = self.DataTableView.indexPathForSelectedRow{
            
            destinationVc.selectedCategory = categories.categoryArray[indexPath.row]
                
                
                destinationVc.index = indexPath.row
                
        }
        
        }
        
    }

   
}
