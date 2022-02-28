import UIKit

class ChooseGameController: UIViewController {

    @IBAction func toRightOnTarget() {
        let generator = Generator<Int>(startValue: 1, endValue: 50)
        let gameRound = GameRound<Int>(generator: generator)
        let game = Game<Int>(gameRound: gameRound, rounds: 5)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "RightOnTarget") { coder in
            return RightOnTargetGameController(coder: coder, game: game)
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func toSelectColor() {
        let generator = Generator<String>()
        let gameRound = GameRound<String>(generator: generator)
        let game = Game(gameRound: gameRound, rounds: 5)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SelectColor") { coder in
            return SelectColorGameController(coder: coder, game: game)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
