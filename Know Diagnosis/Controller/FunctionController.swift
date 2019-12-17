//
//  FunctionController.swift
//  Know Diagnosis
//
//  Created by Rohan  on 12/10/19.
//  Copyright © 2019 Rohan . All rights reserved.
//

import UIKit
import RealmSwift

class FunctionController: UIViewController, UITextFieldDelegate {

    

    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
    }
    
    

 func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    guard let text = textField.text, let range = Range(range, in: text)
        else {
              return true
          }

          let newText = text.replacingCharacters(in: range, with: string)
          let isNumeric = newText.isEmpty || (Double(newText) != nil)
          let numberOfDots = newText.components(separatedBy: ".").count - 1

          let numberOfDecimalDigits: Int
          if let dotIndex = newText.firstIndex(of: ".") {
              numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
          } else {
              numberOfDecimalDigits = 0
          }

          return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
}

}
