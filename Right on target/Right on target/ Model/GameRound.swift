//
//  GameRound.swift
//  Right on target

import UIKit
protocol GameRoundProtocol {
    associatedtype ItemType
    var score: Int {get set}
    var currentSecretValue: ItemType {get set}
    var round: Int {get set}
    func calculateScore(with value: ItemType)
}

class GameRound<T:Comparable>: GameRoundProtocol {
    typealias ItemType = T
    var score: Int = 0
    
    var round: Int = 1
    
    var currentSecretValue: T
    
    func calculateScore(with value: T) {
        if let intValue = value as? Int {
            if let currentIntSecretValue = currentSecretValue as? Int {
                if intValue > currentIntSecretValue {
                    score = 50 - intValue + currentIntSecretValue
                } else if intValue < currentIntSecretValue {
                    score = 50 - currentIntSecretValue + intValue
                } else {
                score = 50
                }
            }
        } else {
            if currentSecretValue == value {
                score = 1
            } else {
                score = 0
            }
        }
    }
    init(generator: Generator<T>!) {
        currentSecretValue = generator.getRandomValue()
    }
}
