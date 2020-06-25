//
//  User.swift
//  CountriesTraveller
//
//  Created by Steew on 14.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import Foundation
import UIKit

struct UserProfile {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    var gender: String = ""
    var imageURL: String = ""
    var image: UIImage?
    var bornDate: String = ""
    var phone: String = ""
    
    var representation: [String: Any] {
        var rep = ["email": email]
        rep["firstName"] = firstName
        rep["lastName"] = lastName
        rep["bornDate"] = bornDate
        rep["gender"] = gender
        rep["phone"] = phone
        rep["imageURL"] = imageURL
        return rep
    }
}
