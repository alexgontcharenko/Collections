//
//  Student.swift
//  UIelements
//
//  Created by Steew on 06.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import Foundation

class Student {
    let name: String
    let surname: String
    var phone: String
    var age: Int
    var picture: UIImage
    var email: String
    
    func toString () -> String {
        return "Имя - \(self.name)\n Фамилия - \(self.surname)\n Телефон -  \(self.phone)\n Возраст - \(self.age)\n Эл. почта - \(self.email)"
    }
    
    init(name: String, surname: String, phone: String, age: Int, picture: UIImage, email: String) {
        self.name = name
        self.surname = surname
        self.phone = phone
        self.age = age
        self.picture = picture
        self.email = email
    }
}

func createStudent () -> [Student] {
    let student1 = Student.init(name: "Alex", surname: "Aliev", phone: "0998765432", age: 26, picture: UIImage(named: "shrek")!, email: "111@ukr.net")
    let student2 = Student.init(name: "Viktor", surname: "Vasiliev", phone: "0678893476", age: 25, picture: UIImage(named: "dirk")!, email: "222@ukr.net")
    let student3 = Student.init(name: "Mike", surname: "Myers", phone: "57896", age: 19, picture: UIImage(named: "fiona")!, email: "999@ukr.net")
    return [student1, student2, student3]
}

class StudentExtramural: Student {
    let shout = "I'm free!!!"
    override func toString() -> String {
        return "Имя - \(self.name), Фамилия - \(self.surname), Телефон -  \(self.phone), Возраст - \(self.age), Эл. почта - \(self.email), \(self.shout)"
    }
    func isStudying(_ : Bool) -> String{
        return "I'm still here"
    }
}

func createStudentEx () -> [StudentExtramural] {
    let student4 = StudentExtramural.init(name: "Olga", surname: "Olina", phone: "8576859", age: 15, picture: UIImage(named: "fiona")!, email: "124512@wer.wer")
    let student5 = StudentExtramural.init(name: "Max", surname: "Maximov", phone: "06783476", age: 30, picture: UIImage(named: "shrek")!, email: "256457@ukr.net")
    let student6 = StudentExtramural.init(name: "Rex", surname: "Raskov", phone: "4535354", age: 27, picture: UIImage(named: "dirk")!, email: "956756@ukr.net")
    return [student4, student5, student6]
}
