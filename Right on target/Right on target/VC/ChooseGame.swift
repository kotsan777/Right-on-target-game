//
//  ChoseGame.swift
//  Right on target
//
//  Created by Аслан Кутумбаев on 02.10.2021.
//

import UIKit

class ChooseGame: UIViewController {
    let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    @IBAction func playRightOnTarget() {
        let viewController = mainStoryboard.instantiateViewController(identifier: "RightOnTarget")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func playSelectColor() {
        let secondViewController = mainStoryboard.instantiateViewController(identifier: "SelectColor")
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}

