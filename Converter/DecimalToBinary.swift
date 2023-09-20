import SwiftUI

func DecimalToBinary(input: String) -> String {
    var binary: [Int] = []
    var decimal = { () -> Int in
        if let decimal = Int(input) {
            return decimal
        } else {
            return 0
        }
    }()
    var place = 0
    while decimal > 0 {
        let bit = decimal % 2
        binary.append(bit)
        place += 1
        decimal = decimal / 2
    }
    var text = ""
    for bit in binary.reversed() {
        text += String(bit)
    }
    return text
}
