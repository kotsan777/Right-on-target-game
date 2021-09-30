//  ViewController.swift
//  Right on target

import UIKit
class ViewController: UIViewController {
    var game: Game!
    @IBOutlet var label: UILabel!
    @IBOutlet var slider: UISlider!
    
    // MARK: - Жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game.init(startValue: 1, endValue: 50, rounds: 5)
        updateLabel(newText: String(game.currentSecretValue))
    }
    
    // MARK: - Взаимодействие View - Model
    
    @IBAction func checkNumber() {
        game.calculateScore(with: Int(slider.value))
        if game.isGameEnded {
            shoewAlertWith(score: game.score)
            game.restartGame()
        }
        else {
            game.startNewRound()
        }
        updateLabel(newText: String(game.currentSecretValue))
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
