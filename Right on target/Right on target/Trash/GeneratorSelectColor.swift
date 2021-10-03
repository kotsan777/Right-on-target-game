//
//  Generat.swift
//  Right on target

import UIKit
protocol GeneratorSelectColorProtocol {
    func getRandomValue() -> String
}

class GeneratorSelectColor: GeneratorSelectColorProtocol {
    private var avalibleChar = [Character("1"),"2","3","4","5","6","7","8","9","A","B","C","D","E","F"]


    func getRandomValue() -> String {
        var hex: String = ""
        while hex.count < 6 {
            hex.append(avalibleChar.randomElement()!)
        }
        return hex
    }
}
