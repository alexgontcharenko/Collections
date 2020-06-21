//
//  DateViewController.swift
//  CountriesTraveller
//
//  Created by Steew on 14.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    @IBOutlet weak var bornDateField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    var user = UserProfile()
    var genderArray = ["Male", "Female", "Other"]
    let datePicker = UIDatePicker()
    let genderPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareDatePicker()
        prepareGenderPicker()
        prepareNextButton()
        prepareBackButton()
        genderPicker.delegate = self
        genderPicker.dataSource = self
    }
    
    func prepareView() {
        dateLabel.text = kDateLabel
        genderField.placeholder = kGenderField
        bornDateField.placeholder = kBornDateField
        bornDateField.inputView = datePicker
        genderField.inputView = genderPicker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapGesture))
        self.view.addGestureRecognizer(tapGesture)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    func prepareNextButton() {
        nextButton.setTitle(kNextButtonTitle, for: .normal)
        nextButton.setTitleColor(UIColor.black, for: .normal)
        nextButton.layer.cornerRadius = 0.5 * nextButton.frame.size.width
        nextButton.clipsToBounds = true
        nextButton.backgroundColor = UIColor.lightText
    }
    
    func prepareBackButton() {
        backButton.setTitle(kBackButtonTitle, for: .normal)
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.layer.cornerRadius = 0.5 * backButton.frame.size.width
        backButton.clipsToBounds = true
        backButton.backgroundColor = UIColor.lightText
        
        backButton.addTarget(self, action: #selector(onTapBackButton), for: .touchUpInside)
    }
    
    func prepareGenderPicker() {
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneActionGender))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        genderField.inputAccessoryView = toolbar
    }
    
    func prepareDatePicker() {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneActionDate))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneButton, spaceButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        bornDateField.inputAccessoryView = toolbar
    }
    
    @objc func doneActionGender() {
        view.endEditing(true)
    }
    
    @objc func doneActionDate() {
        getDateFromDatePicker()
        view.endEditing(true)
    }
    
    @objc func onTapGesture() {
        view.endEditing(true)
    }
    
    func getDateFromDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        bornDateField.text = formatter.string(from: datePicker.date)
        user.bornDate = bornDateField.text!
        print(user.bornDate)
    }
    
    @IBAction func onTapNextButton(_ sender: Any) {
        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController{
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func onTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderField.text = genderArray[row]
        user.gender = genderArray[row]
    }
}
