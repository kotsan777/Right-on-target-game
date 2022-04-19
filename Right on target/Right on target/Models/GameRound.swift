import UIKit


protocol GameRoundProtocol {
    associatedtype ItemType: Comparable
    var score: Int {get set}
    var round: Int {get set}
    var currentSecretValue: ItemType {get set}
    func calculateScore(with value: ItemType)
    func nextRound()
    func reset()
}

class GameRound<T: Comparable>: GameRoundProtocol {
    typealias ItemType = T
    var round: Int
    var score: Int
    var currentSecretValue: T
    var generator: Generator<T>

    init(generator: Generator<T>) {
        score = 0
        round = 1
        self.generator = generator
        currentSecretValue = generator.getRandomValue()
    }

    func nextRound() {
        round += 1
        currentSecretValue = generator.getRandomValue()
    }

    func reset() {
        score = 0
        round = 1
        currentSecretValue = generator.getRandomValue()
    }

    func calculateScore(with value: T) {
        if let intValue = value as? Int, let currentSecretValue = currentSecretValue as? Int {
            guard (intValue != currentSecretValue) else {
                score = 50
                return
            }
            switch intValue > currentSecretValue {
            case true:
                score = 50 - intValue + currentSecretValue
            case false:
                score = 50 - currentSecretValue + intValue
            }
        } else {
            currentSecretValue == value ? (score = 1) : (score = 0)
        }
    }

}
