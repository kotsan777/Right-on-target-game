//
//  Generator.swift
//  Right on target

import UIKit
protocol GeneratorProtocol {
    func getRandomValue() -> Int
}

class Generator: GeneratorProtocol {
    private var minSecretValue: Int
    private var maxSecretValue: Int
    
    init?(startValue: Int, endValue: Int) {
        guard startValue <= endValue else {
            return nil
        }
        minSecretValue = startValue
        maxSecretValue = endValue
    }
    
    func getRandomValue() -> Int {
        (self.minSecretValue...self.maxSecretValue).randomElement()!
    }
}
