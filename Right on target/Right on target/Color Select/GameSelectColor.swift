//
//  Game.swift
//  Right on target


import UIKit
protocol GameSelectColorProtocol {
    var score: Int {get}
    var secretValueGenerator: GeneratorSelectColorProtocol! {get set}
    var currentRound: GameRoundSelectColorProtocol! {get set}
    var isGameEnded: Bool {get}
    func restartGame()
    func startNewRound()
}
class GameSelectColor: GameSelectColorProtocol {
    private var lastRound: Int
    var score: Int = 0
    var secretValueGenerator: GeneratorSelectColorProtocol!
    var currentRound: GameRoundSelectColorProtocol!
    
    var isGameEnded: Bool {
        if currentRound.round >= lastRound {
            self.score += currentRound.score
            return true
        }
        else {
            return false
        }
    }
    
    func restartGame() {
        currentRound.currentSecretValue = secretValueGenerator.getRandomValue()
        currentRound.round = 0
        score = 0
        currentRound.score = 0
        startNewRound()
    }
    
    func startNewRound() {
        currentRound.currentSecretValue = secretValueGenerator.getRandomValue()
        currentRound.round += 1
        score += currentRound.score
    }
    init(rounds: Int, generator: GeneratorSelectColor!, gameRound: GameRoundSelectColor!) {
        self.currentRound = gameRound
        self.lastRound = rounds
        secretValueGenerator = generator
        
    }
}
