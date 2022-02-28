import UIKit

protocol GameProvider {
    associatedtype T: Comparable
    var game: Game<T> {get set}
}

protocol GameProtocol {
    associatedtype T: Comparable
    var gameRound: GameRound<T> {get set}
    var score: Int {get set}
    var isGameEnded: Bool {get}
    func startNewGame()
    func startNewRound()
    func calculateScore()
}


class Game<T: Comparable>: GameProtocol{
    typealias ItemType = T
    var score: Int
    var numberOfRounds: Int
    var gameRound: GameRound<T>
    var isGameEnded: Bool {
        return gameRound.round >= numberOfRounds
    }

    init(gameRound: GameRound<T>,rounds: Int) {
        score = 0
        numberOfRounds = rounds
        self.gameRound = gameRound
    }
    
    func startNewGame() {
        score = 0
        gameRound.reset()
    }

    func calculateScore() {
        score += gameRound.score
    }

    func startNewRound() {
        gameRound.nextRound()
    }
}
