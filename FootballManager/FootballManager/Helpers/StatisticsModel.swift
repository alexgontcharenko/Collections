//
//  Statistics.swift
//  FootballManager
//
//  Created by Steew on 11.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import Foundation

// MARK: - Statistics
struct Statistics: Codable {
    let statistics: StatisticsClass
}

// MARK: - StatisticsClass
struct StatisticsClass: Codable {
    let matchs: Matchs
    let goals: Goals
    let goalsAvg: GoalsAvg
}

// MARK: - Goals
struct Goals: Codable {
    let goalsFor, goalsAgainst: GoalsAgainst
}

// MARK: - GoalsAgainst
struct GoalsAgainst: Codable {
    let home, away, total: Int
}

// MARK: - GoalsAvg
struct GoalsAvg: Codable {
    let goalsFor, goalsAgainst: GoalsAgainstClass
}

// MARK: - GoalsAgainstClass
struct GoalsAgainstClass: Codable {
    let home, away, total: String
}

// MARK: - Matchs
struct Matchs: Codable {
    let matchsPlayed, wins, draws, loses: GoalsAgainst
}
