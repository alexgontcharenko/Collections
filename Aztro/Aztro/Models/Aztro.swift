//
//  Aztro.swift
//  Aztro
//
//  Created by Steew on 08.07.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import Foundation

// MARK: - Aztro
struct Aztro: Codable {
    let dateRange, currentDate, aztroDescription, compatibility: String
    let mood, color, luckyNumber, luckyTime: String

    enum CodingKeys: String, CodingKey {
        case dateRange = "date_range"
        case currentDate = "current_date"
        case aztroDescription = "description"
        case compatibility, mood, color
        case luckyNumber = "lucky_number"
        case luckyTime = "lucky_time"
    }
}

