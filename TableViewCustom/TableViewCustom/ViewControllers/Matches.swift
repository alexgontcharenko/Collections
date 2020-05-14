//
//  Matches.swift
//  TableViewCustom
//
//  Created by Steew on 09.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import Foundation

class Match {
    let nameOfFirstTeam: String
    let nameOfSecondTeam: String
    var image1: UIImage
    var image2: UIImage
    let score: String
    let time: String
    let details: Details
    let players: Players
    
    init(name1: String, name2: String, score: String, time: String, details: Details, players: Players) {
        self.nameOfFirstTeam = name1
        self.nameOfSecondTeam = name2
        self.image1 = UIImage(named: name1)!
        self.image2 = UIImage(named: name2)!
        self.score = score
        self.time = time
        self.details = details
        self.players = players
    }
}

class MatchesGenerator {
    private var arrayOfNames = ["Barcelona", "Arsenal", "Manchester United", "Manchester City", "Real Madrid"]
    private var arrayOfScore: [String]  = ["0 : 1", "0 : 2", "0 : 3", "1 : 0", "1 : 1", "1 : 2", "1 : 3", "2 : 0", "2 : 1", "2 : 2", "2 : 3", "3 : 0", "3 : 1", "3 : 2", "3 : 3"]
    private var arrayOfMatches: [Match] = []
    
    init(count: Int) {
        generate(count: count)
    }
    
    private func generate(count: Int) {
        for _ in 1...count {
            arrayOfMatches.append(Match.init(name1: arrayOfNames.randomElement()!, name2: arrayOfNames.randomElement()!, score: arrayOfScore.randomElement()!, time: "90:00 over", details: Details.init(), players: Players.init()))
        }
    }
    
    func matchCount() -> Int{
        return arrayOfMatches.count
        
    }
    func getMatchByIndex(index: Int) -> Match {
        return arrayOfMatches[index]
    }
}

class Details {
    var arrayOfNameDetails = ["Fouls", "Corners", "Shots", "Shots on target", "Offsides", "Yellow cards", "Red cards"]
    var arrayOfDetailsOne: [String] = ["\(Int.random(in: 1...10))", "\(Int.random(in: 1...10))", "\(Int.random(in: 1...10))", "\(Int.random(in: 1...10))", "\(Int.random(in: 1...10))", "\(Int.random(in: 0...4))", "\(Int.random(in: 0...2))"]
    var arrayOfDetailsTwo: [String] = ["\(Int.random(in: 1...10))", "\(Int.random(in: 1...10))", "\(Int.random(in: 1...10))", "\(Int.random(in: 1...10))", "\(Int.random(in: 1...10))", "\(Int.random(in: 0...4))", "\(Int.random(in: 0...2))"]

    init(){}
}

class Players {
    var playerName = ""
    var playerImg: UIImage? = nil
    var arrayOfPlayerNames = ["Bale", "Ronaldo", "Messi", "Shevchenko", "Crowford", "Totti", "Vieira", "Maradona", "Gusin", "Gusev"]
    var arrayOfPlayerImg: [UIImage?] = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!, UIImage(named: "10")!, UIImage(named: "11")!]
    init(){
        self.playerName = arrayOfPlayerNames.randomElement()!
        self.playerImg = arrayOfPlayerImg.randomElement()!
    }
}
