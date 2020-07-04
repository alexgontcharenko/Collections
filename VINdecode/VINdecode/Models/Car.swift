//
//  Car.swift
//  VINdecode
//
//  Created by Steew on 04.07.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import Foundation

// MARK: - Car
struct Car: Codable {
    let success: Bool
    let vin: String
    let specification: Specification
}

// MARK: - Specification
struct Specification: Codable {
    let vin, year, make, model: String
    let trimLevel, engine, style, madeIn: String
    let steeringType, antiBrakeSystem, tankSize, overallHeight: String
    let overallLength, overallWidth, standardSeating, optionalSeating: String
    let highwayMileage, cityMileage: String

    enum CodingKeys: String, CodingKey {
        case vin, year, make, model
        case trimLevel = "trim_level"
        case engine, style
        case madeIn = "made_in"
        case steeringType = "steering_type"
        case antiBrakeSystem = "anti_brake_system"
        case tankSize = "tank_size"
        case overallHeight = "overall_height"
        case overallLength = "overall_length"
        case overallWidth = "overall_width"
        case standardSeating = "standard_seating"
        case optionalSeating = "optional_seating"
        case highwayMileage = "highway_mileage"
        case cityMileage = "city_mileage"
    }
}

struct Specs {
    let vin, year, make, model: String
    let trimLevel, engine, style, madeIn: String
    let steeringType, antiBrakeSystem, tankSize, overallHeight: String
    let overallLength, overallWidth, standardSeating, optionalSeating: String
    let highwayMileage, cityMileage: String
    
    init?(specData: Specification) {
        vin = specData.vin
        year = specData.year
        make = specData.make
        model = specData.model
        trimLevel = specData.trimLevel
        engine = specData.engine
        style = specData.style
        madeIn = specData.madeIn
        steeringType = specData.steeringType
        antiBrakeSystem = specData.antiBrakeSystem
        tankSize = specData.tankSize
        overallHeight = specData.overallHeight
        overallLength = specData.overallLength
        overallWidth = specData.overallWidth
        standardSeating = specData.standardSeating
        optionalSeating = specData.optionalSeating
        highwayMileage = specData.highwayMileage
        cityMileage = specData.cityMileage
    }
}
