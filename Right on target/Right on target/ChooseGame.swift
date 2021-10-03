//
//  ChoseGame.swift
//  Right on target
//
//  Created by Аслан Кутумбаев on 02.10.2021.
//

import UIKit

class ChooseGame: UIViewController {
    
    @IBAction func playRightOnTarget() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "RightOnTarget")
        self.present(viewController, animated: true, completion: nil)
    }
    @IBAction func playSelectColor() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(identifier: "SelectColor")
        self.present(secondViewController, animated: true, completion: nil)
    }
}
