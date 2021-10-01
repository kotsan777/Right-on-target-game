//
//  GameRound.swift
//  Right on target

import UIKit
protocol GameRoundProtocol {
    var score: Int {get}
    var currentSecretValue: Int! {get set}
    var round: Int {get set}
    func calculateScore(with value: Int)
}

class GameRound: GameRoundProtocol {
    var score: Int = 0
    var round: Int = 1
    
    var currentSecretValue: Int! = 0
    
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score = 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score = 50 - currentSecretValue + value
        } else {
            score = 50
        }
    }
    init(generator: Generator!) {
        currentSecretValue = generator.getRandomValue()
    }
}
