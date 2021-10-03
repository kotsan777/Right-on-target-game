//  ViewController.swift
//  Right on target

import UIKit
class RightOnTarget: UIViewController {
    var game: Game!
    var gameRound: GameRound!
    var generator: Generator!
    @IBOutlet var label: UILabel!
    @IBOutlet var slider: UISlider!
    
    // MARK: - Жизненный цикл
    
    override func loadView() {
        super.loadView()
        generator = Generator.init(startValue: 1, endValue: 50)
        gameRound = GameRound.init(generator: generator)
        game = Game.init(rounds: 5, generator: generator, gameRound: gameRound)
        updateLabel(newText: String(gameRound.currentSecretValue))
    }
    
    // MARK: - Взаимодействие View - Model
    
    @IBAction func checkNumber() {
        gameRound.calculateScore(with: Int(slider.value))
        if game.isGameEnded {
            shoewAlertWith(score: game.score)
            game.restartGame()
        }
        else {
            game.startNewRound()
        }
        updateLabel(newText: String(gameRound.currentSecretValue))
    }
    
    @IBAction func hideCurrentScene() {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Обновление View
    
    private func shoewAlertWith(score: Int) {
        let alert = UIAlertController.init(title: "Игра окончена", message: "Вы заработали \(score) очков", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Начать заново", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    private func updateLabel(newText: String) {
        label.text = newText
    }
}
