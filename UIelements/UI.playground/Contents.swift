//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//
//  ViewController.swift
//  UIelements
//
//  Created by Steew on 02.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

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
    StudentClass.init(name: "Alexander", surname: "Gontcharenko", phone: "0998765432", age: 26, picture: nil, email: "111@ukr.net"),
    StudentClass.init(name: "Viktor", surname: "Vasiliev", phone: "0678893476", age: 25, picture: nil, email: "222@ukr.net")]

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
        studentLabel.text = "\(StudentClass.init(name: "asd", surname: "asd", phone: "asd", age: 21, picture: nil, email: "asd"))"
    }
    
}
