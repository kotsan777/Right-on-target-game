import UIKit

class GameOverAlertController: UIAlertController {

    private enum AlertMessage {
        static let gameOverTitle = "Game over"
        static let gameOverMessage = "Your score:"
        static let actionTitle = "Ok"
    }

    init(score: Int) {
        super.init(nibName: nil, bundle: nil)
        let scoreString = String(score)
        title = AlertMessage.gameOverTitle
        message = AlertMessage.gameOverMessage
        message?.append(scoreString)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addCustomAction(handler: ((UIAlertAction) -> ())?) {
        let action = UIAlertAction(title: AlertMessage.actionTitle, style: .default, handler: handler)
        addAction(action)
    }
}
