//  Game.swift
//  Right on target
import UIKit
protocol GameProtocol {
    var score: Int {get}
    var secretValueGenerator: GeneratorProtocol! {get}
    var currentRound: GameRoundProtocol! {get set}
    var isGameEnded: Bool {get}
    func restartGame()
    func startNewRound()
}

class Game: GameProtocol {
    var score: Int = 0
    var secretValueGenerator: GeneratorProtocol!
    private var lastRound: Int
    var currentRound: GameRoundProtocol!
    
    var isGameEnded: Bool {
        if currentRound.round >= lastRound {
            return true
        }
        else {
            return false
        }
    }
    
    func restartGame() {
        currentRound.currentSecretValue = secretValueGenerator.getRandomValue()
        currentRound.round = 1
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        currentRound.currentSecretValue = secretValueGenerator.getRandomValue()
        currentRound.round += 1
        score += currentRound.score
    }
    
    init?(rounds: Int, generator: Generator!, currentRound: GameRoundProtocol!) {
        self.currentRound = currentRound
        lastRound = rounds
        secretValueGenerator = generator
    }
}
