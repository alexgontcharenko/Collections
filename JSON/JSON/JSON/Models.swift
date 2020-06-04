//
//  Models.swift
//  JSON
//
//  Created by Steew on 02.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import Foundation

struct Post {
    var body: String = ""
    var id: Int = 0
    var title: String = ""
    var userId: Int = 0
}

struct Person: Codable {
    var body: String
    var id: Int
    var title: String
    var userId: Int
}

struct AlamoPerson: Codable {
    var body: String
    var id: Int
    var title: String
    var userId: Int
}
