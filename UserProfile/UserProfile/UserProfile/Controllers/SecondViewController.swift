//
//  SecondViewController.swift
//  UserProfile
//
//  Created by Steew on 12.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    
    let pickerView: UIPickerView = UIPickerView()
    var selectedAge: Int?
    var array = [0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.orange
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        ageField.delegate = self
        appendArray()
        dismissPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        ageField.inputView = pickerView
    }
    
    func appendArray() {
        for i in 1...100 {
            self.array.append(i)
        }
    }
    
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
        let button = UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(self.donePicker))
       //let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       ageField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(array[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAge = array[row]
        ageField.text = String(selectedAge!)
    }
       
   
}
