//
//  Model.swift
//  NetworkManager
//
//  Created by Steew on 12.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import Foundation

struct Team {
var teamID = 0
    var name = ""
var code = ""
var logo = ""
var country = ""
var isNational = false
var founded = 0
var venueName = ""
var venueSurface = ""
var venueAddress = ""
var venueCity = ""
var venueCapacity = 0
}

//// MARK: - CurrentData
//struct CurrentData: Codable {
//    let api: API
//}
//
//// MARK: - API
//struct API: Codable {
//    let results: Int
//    let teams: [Team]
//}
//
//// MARK: - Team
//struct Team: Codable {
//    let teamID: Int
//    let name: String
//    let code: String?
//    let logo: String
//    let country: String
//    let isNational: Bool
//    let founded: Int
//    let venueName: String
//    let venueSurface: String
//    let venueAddress, venueCity: String
//    let venueCapacity: Int
//
//    enum CodingKeys: String, CodingKey {
//        case teamID = "team_id"
//        case name, code, logo, country
//        case isNational = "is_national"
//        case founded
//        case venueName = "venue_name"
//        case venueSurface = "venue_surface"
//        case venueAddress = "venue_address"
//        case venueCity = "venue_city"
//        case venueCapacity = "venue_capacity"
//    }
//}
//
//enum Country: String, Codable {
//    case england = "England"
//    case wales = "Wales"
//}
//
//enum VenueSurface: String, Codable {
//    case grass = "grass"
//}

