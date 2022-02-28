import UIKit

private enum Constants {
    static let scoreTitle = "Score:"
    static let roundTitle = "Round:"
}

class RightOnTargetGameController: UIViewController, GameProvider {
    typealias T = Int

    var game: Game<T>
    @IBOutlet var secretValueLabel: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!

    init?(coder: NSCoder, game: Game<Int>) {
        self.game = game
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func checkNumber() {
        let gameRound = game.gameRound
        let secretValue = gameRound.currentSecretValue
        let sliderValue = Int(slider.value)
        gameRound.calculateScore(with: sliderValue)
        if game.isGameEnded {
            game.calculateScore()
            showAlertWith(score: game.score)
        } else {
            game.calculateScore()
            game.startNewRound()
        }
        updateLabels(secretValue: secretValue, score: game.score, currentRound: gameRound.round, allRounds: game.numberOfRounds)
    }

    @IBAction func restoreGame() {
        let gameRound = game.gameRound
        let secretValue = gameRound.currentSecretValue
        game.startNewGame()
        updateLabels(secretValue: secretValue, score: game.score, currentRound: gameRound.round, allRounds: game.numberOfRounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let gameRound = game.gameRound
        let secretValue = gameRound.currentSecretValue
        updateLabels(secretValue: secretValue, score: game.score, currentRound: gameRound.round, allRounds: game.numberOfRounds)
    }

    private func showAlertWith(score: Int) {
        let alert = GameOverAlertController(score: score)
        alert.addCustomAction {[weak self] _ in
            guard let self = self else {
                return
            }
            self.restoreGame()
        }
        present(alert, animated: true, completion: nil)
    }

    private func updateSecretValueLabel(secretValue: Int) {
        let value = String(secretValue)
        secretValueLabel.text = value
    }

    private func updateScoreLabel(score: Int) {
        let scoreTitle = Constants.scoreTitle
        let fullScoreTitle = "\(scoreTitle) \(score)"
        scoreLabel.text = fullScoreTitle
    }

    private func updateRoundLabel(currentRound: Int, allRounds: Int) {
        let roundTitle = Constants.roundTitle
        let fullRoundTitle = "\(roundTitle) \(currentRound) / \(allRounds)"
        roundLabel.text = fullRoundTitle
    }

    private func updateLabels(secretValue: Int, score: Int, currentRound: Int, allRounds: Int) {
        updateSecretValueLabel(secretValue: secretValue)
        updateScoreLabel(score: score)
        updateRoundLabel(currentRound: currentRound, allRounds: allRounds)
    }
}
