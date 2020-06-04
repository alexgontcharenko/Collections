//
//  Models.swift
//  FootballManager
//
//  Created by Steew on 04.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CurrentData
struct CurrentData: Codable {
    let api: API
}

// MARK: - API
struct API: Codable {
    let results: Int
    let teams: [Team]
}

// MARK: - Team
struct Team: Codable {
    let teamID: Int
    let name: String
    let code: String?
    let logo: String
    let country: String
    let isNational: Bool
    let founded: Int
    let venueName: String
    let venueSurface: String
    let venueAddress, venueCity: String
    let venueCapacity: Int

    enum CodingKeys: String, CodingKey {
        case teamID = "team_id"
        case name, code, logo, country
        case isNational = "is_national"
        case founded
        case venueName = "venue_name"
        case venueSurface = "venue_surface"
        case venueAddress = "venue_address"
        case venueCity = "venue_city"
        case venueCapacity = "venue_capacity"
    }
}

enum Country: String, Codable {
    case england = "England"
    case wales = "Wales"
}

enum VenueSurface: String, Codable {
    case grass = "grass"
}

//struct CurrentData: Codable {
//    let api: Api
//}
//
//struct Api: Codable {
//    let teams: [GetTeams]
//}
//
//struct GetTeams: Codable {
//    let team_id: Int
//    let name: String
//    let code: String?
//    let logo: String
//    let country: String
//    let is_national: Bool
//    let founded: Int
//    let venue_name: String
//    let venue_surface: String
//    let venue_address: String
//    let venue_city: String
//    let venue_capacity: Int
//}
//
//struct Team {
//    let team_id: Int
//    let name: String
//    let logo: String
//
//    init?(teamData: GetTeams) {
//        team_id = teamData.team_id
//        name = teamData.name
//        logo = teamData.logo
//    }
//}

func getImage(from string: String) -> UIImage? {
    //2. Get valid URL
    guard let url = URL(string: string)
        else {
            print("Unable to create URL")
            return nil
    }

    var image: UIImage? = nil
    do {
        //3. Get valid data
        let data = try Data(contentsOf: url, options: [])

        //4. Make image
        image = UIImage(data: data)
    }
    catch {
        print(error.localizedDescription)
    }

    return image
}

//1. Get valid string
//let string = "https://images.freeimages.com/images/large-previews/f2c/effi-1-1366221.jpg"
//
//if let image = getImage(from: string) {
//    //5. Apply image
//    cell.imageView.image = image
//}



