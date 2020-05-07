//
//  ViewController.swift
//  UIelements
//
//  Created by Steew on 02.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var studentTable: UITableView!
    @IBOutlet weak var studentLabel: UILabel!
    @IBOutlet weak var studentField: UITextField!
    @IBOutlet weak var studentButton: UIButton!
    @IBOutlet weak var studentImage: UIImageView!
    
    var arrayOfStudents = [Student]()
    var arrayOfStudentsEx = createStudentEx()
    override func viewDidLoad() {
        super.viewDidLoad()
        studentButton.setTitle("Find", for: .normal)
        studentLabel.text = "Find student"
        self.arrayOfStudents = createStudent()
        self.studentTable.delegate = self
        self.studentTable.dataSource = self
    }
    
    func searchStudent(find: String) -> Student? {                        
        return arrayOfStudents.first {$0.surname.lowercased() == find.lowercased()}
    }
    
    @IBAction func onPressButton(_ sender: Any) {
        if let student = searchStudent(find: studentField.text!){
            studentLabel.text = student.toString()
            studentImage.image = student.picture
        } else {
            studentLabel.text = "This student doesn't exist"
        }
        
    }
    
    
 public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayOfStudentsEx.count
    }
    
 public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
    cell.textLabel?.text = "\(arrayOfStudentsEx[indexPath.row].toString())"
        return cell
    }
    
}


