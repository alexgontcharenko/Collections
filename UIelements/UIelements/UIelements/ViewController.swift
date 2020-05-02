//
//  ViewController.swift
//  UIelements
//
//  Created by Steew on 02.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
class StudentClass {
    let name: String
    let surname: String
    var phone: String
    var age: Int
    var picture: UIImage?
    var email: String
    
    init(name: String, surname: String, phone: String, age: Int, picture: UIImage?, email: String) {
        self.name = name
        self.surname = surname
        self.phone = phone
        self.age = age
        self.picture = picture
        self.email = email
    }
}

struct StudentStruct {
    let name: String
    let surname: String
    var phone: String
    var age: Int
    var picture: UIImage?
    var email: String
    }

let student1 = StudentStruct(name: "", surname: "", phone: "", age: 1, email: "")

let arrayOfStudents: [StudentClass] = [
    StudentClass.init(name: "Alex", surname: "Aliev", phone: "0998765432", age: 26, picture: nil, email: "111@ukr.net"),
    StudentClass.init(name: "Viktor", surname: "Vasiliev", phone: "0678893476", age: 25, picture: nil, email: "222@ukr.net"),
    StudentClass.init(name: "Mike", surname: "Myers", phone: "57896", age: 19, picture: nil, email: "999@ukr.net")]

class ViewController: UIViewController {
    @IBOutlet weak var studentLabel: UILabel!
    @IBOutlet weak var studentField: UITextField!
    @IBOutlet weak var studentButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentButton.setTitle("Find", for: .normal)
        studentLabel.text = "Find student"
    }
    @IBAction func onPressButton(_ sender: Any) {
        let getSurname = studentField.text!
        for student in arrayOfStudents{
            if getSurname == student.surname {
                studentLabel.text = "Имя - \(student.name)\n Фамилия - \(student.surname)\n Телефон -  \(student.phone)\n Возраст - \(student.age)\n Эл. почта - \(student.email)"
            }
        }
        
    }
    
}

