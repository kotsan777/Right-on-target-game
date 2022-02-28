import UIKit

protocol GeneratorProtocol {
    associatedtype ItemType
    func getRandomValue() -> ItemType
}

private enum Constants {
    static let numericRange: [Character] = ["1","2","3","4","5","6","7","8","9"]
    static let letterRange: [Character] = ["A","B","C","D","E","F"]
}

class Generator<T: Comparable>: GeneratorProtocol {
    typealias ItemType = T
    private var minSecretValue: Int = 0
    private var maxSecretValue: Int = 0
    private var randomValue: T

    init(startValue: Int, endValue: Int) {
        minSecretValue = startValue
        maxSecretValue = endValue
        randomValue = Int() as! T
    }

    init() {
        randomValue = String() as! T
    }

    func getRandomValue() -> T {
        if let _ = randomValue as? Int,
           let randomValue = (minSecretValue...maxSecretValue).randomElement() as? T {
            self.randomValue = randomValue
        } else {
            let hex = generateHex()
            guard let hex = hex as? T else {
                return self.randomValue
            }
            randomValue = hex
        }
        return randomValue
    }

    private func generateHex() -> String {
        var hex = ""
        let numericArray = Constants.numericRange
        let letterArray = Constants.letterRange
        var resultArray = numericArray
        resultArray.append(contentsOf: letterArray)
        while hex.count < 6 {
            guard let newElement = resultArray.randomElement() else {
                return hex
            }
            hex.append(newElement)
        }
        return hex
    }
}
