//
//  Generator.swift
//  Right on target

import UIKit
protocol GeneratorProtocol {
    associatedtype ItemType
    func getRandomValue() -> ItemType
}



class Generator<T: Comparable>: GeneratorProtocol {
    typealias ItemType = T
    private var minSecretValue: Int = 0
    private var maxSecretValue: Int = 0
    private var avalibleChar = [Character("1"),"2","3","4","5","6","7","8","9","A","B","C","D","E","F"]
    private var randomValue: T
    
    
    func getRandomValue() -> T {
        if let _ = randomValue as? Int {
            randomValue = (self.minSecretValue...self.maxSecretValue).randomElement() as! T
            return randomValue
        }
        else {
            var hex = ""
            while hex.count < 6 {
                hex.append(avalibleChar.randomElement()!)
            }
            randomValue = hex as! T
        }
        return randomValue
    }
        

    
    init?(startValue: Int, endValue: Int) {
        guard startValue <= endValue else {
            return nil
        }
        minSecretValue = startValue
        maxSecretValue = endValue
        randomValue = Int() as! T
    }
    
    init() {
        randomValue = String() as! T
    }
}
