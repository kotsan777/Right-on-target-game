//
//  GameRound.swift
//  Right on target

import UIKit
protocol GameRoundSelectColorProtocol {
    var score: Int {get set}
    var currentSecretValue: String {get set}
    var round: Int {get set}
    func calculateScore(with value: String)
}

class GameRoundSelectColor: GameRoundSelectColorProtocol {
    var score: Int = 0
    
    var currentSecretValue: String
    
    var round = 1
    
    func calculateScore(with value: String) {
        if currentSecretValue == value {
            score = 1
        }
        else {
            score = 0
        }
    }
    init(generator: GeneratorSelectColor) {
        currentSecretValue = generator.getRandomValue()
    }
    
}
