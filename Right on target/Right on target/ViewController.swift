//  ViewController.swift
//  Right on target

import UIKit

class ViewController: UIViewController {
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    var number: Int = 0
    var round: Int = 1
    var points: Int = 0
    @IBAction func checkNumber() {
            let numSlider = Int(self.slider.value.rounded())
            if numSlider > number {
                points += 50 - numSlider + number
            }
            else if numSlider < number {
                points += 50 - number + numSlider
            }
            else {
                points += 50
            }
            if self.round == 5 {
                let alert = UIAlertController.init(
                    title: "Игра окончена",
                    message: "Вы заработали \(points) очков",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                round += 1
            }
            self.number = Int.random(in: 1...50)
            self.label.text = String(self.number)
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.number = Int.random(in: 1...50)
        self.label.text = String(self.number)
    }
}

