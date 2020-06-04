//
//  ViewController.swift
//  JSON
//
//  Created by Steew on 02.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var codableButton: UIButton!
    @IBOutlet weak var alamofireButton: UIButton!
    
    var posts = [Post]()
    var persons = [Person]()
    var alamoPersons = [AlamoPerson]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func onTapRequest(_ sender: Any) {
        guard let url = URL.init(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let _ = response else { return }
            guard let data = data else { return }
            
            //let decoder = JSONDecoder()
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                //print(json)
                for eachData in json as! Array<AnyObject> {
                    var post = Post()
                    post.body = eachData["body"] as! String
                    post.id = eachData["id"] as! Int
                    post.title = eachData["title"] as! String
                    post.userId = eachData["userId"] as! Int
                    
                    self.posts.append(post)
                }
                print(self.posts.count)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    @IBAction func onCodableTap(_ sender: Any) {
        guard let url = URL.init(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let _ = response else { return }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                //print(json)
                self.persons = try decoder.decode([Person].self, from: data)
                
                print(self.persons.count)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    @IBAction func alamofireTap(_ sender: Any) {
        guard let url = URL.init(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        AF.request(url).response { response in
            debugPrint(response)
            let decoder = JSONDecoder()
            
            do {
                guard let data = response.data else { return }
                self.alamoPersons = try decoder.decode([AlamoPerson].self, from: data)
                print(self.alamoPersons.count)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

