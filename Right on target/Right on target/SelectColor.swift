//
//  SecondViewController.swift
//  Right on target

import UIKit

class SelectColor: UIViewController {
    var game: Game<String>!
    var gameRound: GameRound<String>!
    var generator: Generator<String>!
    @IBOutlet var randomColorLabel: UILabel!
    @IBOutlet var buttonColor1: UIButton!
    @IBOutlet var buttonColor2: UIButton!
    @IBOutlet var buttonColor3: UIButton!
    @IBOutlet var buttonColor4: UIButton!
    
    // MARK: - Жизненный цикл
    
    override func loadView() {
        super.loadView()
        generator = Generator.init()
        gameRound = GameRound.init(generator: generator)
        game = Game.init(rounds: 5, generator: generator, gameRound: gameRound)
        updateHexColorLabel()
        updateVariants()
        
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
        
    }
    
    
    @IBAction func hideCurrentScene() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Обновление View
    
    func updateHexColorLabel() {
        randomColorLabel.text = "#\(gameRound.currentSecretValue)"
    }
    
    func updateVariants() {
        let arrayOfButtons = [buttonColor1,buttonColor2,buttonColor3,buttonColor4]
        
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
    
}