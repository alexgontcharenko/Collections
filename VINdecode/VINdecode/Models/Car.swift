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
    let steeringType, antiBrakeSystem: String
    let tankSize: JSONNull?
    let overallHeight, overallLength, overallWidth, standardSeating: String
    let optionalSeating: JSONNull?
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

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
