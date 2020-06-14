//
//  DateViewController.swift
//  CountriesTraveller
//
//  Created by Steew on 14.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var bornDatePicker: UIDatePicker!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    var user = UserProfile()
    var genderArray = ["Male", "Female", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        genderPicker.delegate = self
        genderPicker.dataSource = self
        bornDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    func prepareView() {
        dateLabel.text = kDateLabel
        genderLabel.text = kGenderLabel
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("\(day) \(month) \(year)")
        }
    }
    @IBAction func onTapNextButton(_ sender: Any) {
        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController{
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
        }
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
        user.gender = genderArray[row]
    }
}
