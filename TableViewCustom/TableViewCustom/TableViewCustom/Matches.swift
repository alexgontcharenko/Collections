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
    let image1: UIImage
    let image2: UIImage
    let score: String
    let time: String
    
    init(image1: UIImage, image2: UIImage, score: String, time: String) {
        self.image1 = image1
        self.image2 = image2
        self.score = score
        self.time = time
    }
}

let arrayOfImages = [UIImage(named: "Barcelona"), UIImage(named: "Arsenal"), UIImage(named: "ManU"), UIImage(named: "ManCity"), UIImage(named: "Real")]

let arrayOfScore = ["0 : 1", "0 : 2", "0 : 3", "1 : 0", "1 : 1", "1 : 2", "1 : 3", "2 : 0", "2 : 1", "2 : 2", "2 : 3", "3 : 0", "3 : 1", "3 : 2", "3 : 3"]

let arrayOfMatches: [Match] = [
    Match.init(image1: arrayOfImages.randomElement()!!, image2: arrayOfImages.randomElement()!!, score: arrayOfScore.randomElement()!, time: "90:00 over"),
    Match.init(image1: arrayOfImages.randomElement()!!, image2: arrayOfImages.randomElement()!!, score: arrayOfScore.randomElement()!, time: "90:00 over"),
    Match.init(image1: arrayOfImages.randomElement()!!, image2: arrayOfImages.randomElement()!!, score: arrayOfScore.randomElement()!, time: "90:00 over"),
    Match.init(image1: arrayOfImages.randomElement()!!, image2: arrayOfImages.randomElement()!!, score: arrayOfScore.randomElement()!, time: "90:00 over"),
    Match.init(image1: arrayOfImages.randomElement()!!, image2: arrayOfImages.randomElement()!!, score: arrayOfScore.randomElement()!, time: "90:00 over"),
    Match.init(image1: arrayOfImages.randomElement()!!, image2: arrayOfImages.randomElement()!!, score: arrayOfScore.randomElement()!, time: "90:00 over"),
    Match.init(image1: arrayOfImages.randomElement()!!, image2: arrayOfImages.randomElement()!!, score: arrayOfScore.randomElement()!, time: "90:00 over"),
    Match.init(image1: arrayOfImages.randomElement()!!, image2: arrayOfImages.randomElement()!!, score: arrayOfScore.randomElement()!, time: "90:00 over"),
    Match.init(image1: arrayOfImages.randomElement()!!, image2: arrayOfImages.randomElement()!!, score: arrayOfScore.randomElement()!, time: "90:00 over"),
    Match.init(image1: arrayOfImages.randomElement()!!, image2: arrayOfImages.randomElement()!!, score: arrayOfScore.randomElement()!, time: "90:00 over")]

func randomMatch (array: [Match]) -> Match {
    return arrayOfMatches.randomElement()!
}
