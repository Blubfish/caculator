import SwiftUI

func BinaryToDecimal(binary: [Bool]) -> Int {
    var position = 0.0
    var output = 0
    for num in binary.reversed() {
        if num {
            output += Int(pow(2.0, position))
        }
        position += 1
    }
    return output
}

func DecimalToBinary(decimal: Int) -> [Bool] {
    var decimal = decimal
    var binary: [Bool] = []
    var place = 0
    while decimal > 0 {
        let bit = decimal % 2
        binary.append(bit != 0)
        place += 1
        decimal = decimal / 2
    }
    return binary
}
