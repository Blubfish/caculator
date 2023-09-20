import SwiftUI

func BinaryToDecimal(input: String) -> String {
    var binary: [Int] = []
    for bit in input {
        if let bit = Int(String(bit)) {
            if bit == 1 {
                binary.append(1)
                continue
            }
            binary.append(0)
        } else {
            return "error"
        }
    }
    var position = 0.0
    var output = 0
    for num in binary.reversed() {
        if num == 1 {
            output += Int(pow(2.0, position))
        }
        position += 1
    }
    return String(output)
}
