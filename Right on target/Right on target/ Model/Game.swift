//  Game.swift
//  Right on target
import UIKit
protocol GameProtocol {
    associatedtype ItemType: Comparable
    var score: Int {get}
    var secretValueGenerator: Generator<ItemType>! {get set}
    var currentRound: GameRound<ItemType>! {get set}
    var isGameEnded: Bool {get}
    func restartGame()
    func startNewRound()
}

class Game<T: Comparable>: GameProtocol {
    typealias ItemType = T
    var score: Int = 0
    var secretValueGenerator: Generator<ItemType>!
    private var lastRound: Int
    var currentRound: GameRound<ItemType>!
    
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
    
    init?(rounds: Int, generator: Generator<T>!, gameRound: GameRound<T>!) {
        self.currentRound = gameRound
        lastRound = rounds
        secretValueGenerator = generator
    }
}
