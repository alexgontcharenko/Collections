//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

var moneySet: Set = ["1 dollar", "2 dollars", "5 dollars", "20 dollars"]
var coinSet: Set = ["1 dollar", "50 cent"]
moneySet.insert("50 dollars")
moneySet.remove("2 dollars")
print(moneySet)
moneySet.removeFirst()
print(moneySet)
moneySet.contains("1 dollar")
moneySet.isEmpty
moneySet.symmetricDifference(coinSet)
moneySet.intersection(coinSet)
moneySet.union(coinSet)
moneySet.subtracting(coinSet)
