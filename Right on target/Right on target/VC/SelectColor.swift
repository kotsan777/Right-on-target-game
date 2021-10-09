//
//  SecondViewController.swift
//  Right on target

import UIKit

class SelectColor: UIViewController {
    var game: Game<String>!
    var gameRound: GameRound<String>!
    var generator: Generator<String>!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    @IBOutlet var randomColorLabel: UILabel!
    @IBOutlet var buttonColor1: UIButton!
    @IBOutlet var buttonColor2: UIButton!
    @IBOutlet var buttonColor3: UIButton!
    @IBOutlet var buttonColor4: UIButton!
    @IBOutlet var buttonColor5: UIButton!
    
    // MARK: - Жизненный цикл
    
    override func loadView() {
        super.loadView()
        generator = Generator.init()
        gameRound = GameRound.init(generator: generator)
        game = Game.init(rounds: 5, generator: generator, gameRound: gameRound)
        squareToCircle()
        updateHexColorLabel()
        updateVariants()
        setLabelStyle()
        updateScoreLabel(score: game.score)
        updateRoundLabel(currentRound: gameRound.round, rounds: game.lastRound)
    }
    
    // MARK: - Взаимодействие View - Model
    
    @IBAction func checkNumber(_ sender: UIButton) {
        gameRound.calculateScore(with: sender.backgroundColor!.toHex()!)
        if game.isGameEnded {
            shoewAlertWith(score: game.score)
            game.restartGame()
        }
        else {
            game.startNewRound()
        }
        updateHexColorLabel()
        updateVariants()
        updateScoreLabel(score: game.score)
        updateRoundLabel(currentRound: gameRound.round, rounds: game.lastRound)
        
    }
    
    @IBAction func restoreGame() {
        game.restartGame()
        updateHexColorLabel()
        updateVariants()
        updateScoreLabel(score: game.score)
        updateRoundLabel(currentRound: gameRound.round, rounds: game.lastRound)
    }
    
    
    // MARK: - Обновление View
    
    func updateHexColorLabel() {
        randomColorLabel.text = "#\(gameRound.currentSecretValue)"
    }
    
    func updateVariants() {
        let arrayOfButtons = [buttonColor1,buttonColor2,buttonColor3,buttonColor4,buttonColor5]
        
        for i in arrayOfButtons {
            if let buttons = i {
                buttons.backgroundColor = UIColor.init(hex: generator.getRandomValue())
            }
        }
        
        if let randomButton = arrayOfButtons.randomElement() {
            randomButton?.backgroundColor = UIColor.init(hex: gameRound.currentSecretValue)
        }
    }
    
    private func shoewAlertWith(score: Int) {
        let alert = UIAlertController.init(title: "Игра окончена", message: "Вы заработали \(score) очков", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Начать заново", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func squareToCircle() {
        let arrayOfButtons = [buttonColor1,buttonColor2,buttonColor3,buttonColor4,buttonColor5]
        for i in arrayOfButtons {
            i?.layer.cornerRadius = 45
        }
    }
    private func setLabelStyle() {
        randomColorLabel.layer.masksToBounds = true
        randomColorLabel.layer.cornerRadius = 10
        randomColorLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func updateScoreLabel(score: Int) {
        scoreLabel.text = "Очки: \(score)"
    }
    private func updateRoundLabel(currentRound: Int, rounds: Int) {
        roundLabel.text = "Раунд: \(currentRound) / \(rounds)"
    }
}
