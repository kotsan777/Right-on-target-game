import UIKit

private enum Constants {
    static let labelCornerRadius: CGFloat = 10
    static let scoreTitle = "Score:"
    static let roundTitle = "Round:"
}

class SelectColorGameController: UIViewController, GameProvider {
    typealias T = String

    var game: Game<T>
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    @IBOutlet var randomColorLabel: UILabel!
    @IBOutlet var buttonColor1: ColorButton!
    @IBOutlet var buttonColor2: ColorButton!
    @IBOutlet var buttonColor3: ColorButton!
    @IBOutlet var buttonColor4: ColorButton!
    @IBOutlet var buttonColor5: ColorButton!

    init?(coder: NSCoder, game: Game<T>) {
        self.game = game
        super.init(coder: coder )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func checkColor(_ sender: UIButton) {
        guard let currentHex = sender.backgroundColor?.toHex else {
            return
        }
        let gameRound = game.gameRound
        gameRound.calculateScore(with: currentHex)
        if game.isGameEnded {
            game.calculateScore()
            shoewAlertWith(score: game.score)
        } else {
            game.calculateScore()
            game.startNewRound()
        }
        updateLabels(score: game.score, currentRound: gameRound.round, allRounds: game.numberOfRounds, secretValue: gameRound.currentSecretValue)
    }

    @IBAction func restoreGame() {
        let gameRound = game.gameRound
        game.startNewGame()
        updateLabels(score: game.score, currentRound: gameRound.round, allRounds: game.numberOfRounds, secretValue: gameRound.currentSecretValue)
    }

    override func loadView() {
        super.loadView()
        let gameRound = game.gameRound
        setLabelStyle()
        updateLabels(score: game.score, currentRound: gameRound.round, allRounds: game.numberOfRounds, secretValue: gameRound.currentSecretValue)
    }

    private func updateVariants() {
        let arrayOfButtons = [buttonColor1,buttonColor2,buttonColor3,buttonColor4,buttonColor5]
        arrayOfButtons.forEach { button in
            guard let button = button else {
                return
            }
            let hex = game.gameRound.generator.getRandomValue()
            button.backgroundColor = UIColor(hex: hex)
        }
        guard let randomButton = arrayOfButtons.randomElement() else {
            return
        }
        randomButton?.backgroundColor = UIColor(hex: game.gameRound.currentSecretValue)
    }

    private func shoewAlertWith(score: Int) {
        let alert = GameOverAlertController(score: score)
        alert.addCustomAction {[weak self] _ in
            guard let self = self else {
                return
            }
            self.restoreGame()
        }
        present(alert, animated: true, completion: nil)
    }

    private func setLabelStyle() {
        randomColorLabel.layer.cornerRadius = Constants.labelCornerRadius
    }

    private func updateHexLabel(with secretValue: T) {
        randomColorLabel.text = "#\(secretValue)"
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

    private func updateLabels(score: Int, currentRound: Int, allRounds: Int, secretValue: T) {
        updateVariants()
        updateHexLabel(with: secretValue)
        updateScoreLabel(score: score)
        updateRoundLabel(currentRound: currentRound, allRounds: allRounds)
    }
}
