import SwiftUI

func BinaryToHexadecimal(binary: [Bool]) -> String {
    var hexadecimal = ""
    for nibble in binary.nibbles().reversed() {
        hexadecimal += { (decimal: Int) -> String in
            if decimal < 10 {
                return String(decimal)
            } else if decimal == 10 {
                return "A"
            } else if decimal == 11 {
                return "B"
            } else if decimal == 12 {
                return "C"
            } else if decimal == 13 {
                return "D"
            } else if decimal == 14 {
                return "E"
            } else if decimal == 15 {
                return "F"
            }
            return ""
        }(BinaryToDecimal(binary: nibble))
    }
    return hexadecimal
}

func HexadecimalToBinary(hexadecimal: String) -> [Bool] {
    var binary: [Bool] = []
    for (index, digit) in hexadecimal.enumerated() {
        binary = { () -> [Bool] in
            var binary = DecimalToBinary(decimal: { (digit: String) -> Int in
                if digit == "a" {
                    return 10
                } else if digit == "b" {
                    return 11
                } else if digit == "c" {
                    return 12
                } else if digit == "d" {
                    return 13
                } else if digit == "e" {
                    return 14
                } else if digit == "f" {
                    return 15
                }
                if let digit = Int(digit) {
                    return digit
                }
                return 0
            }(digit.lowercased()))
            if index != 0 {
                var padding = 4 - binary.count
                while padding > 0 {
                    binary += [false]
                    padding -= 1
                }
            }
            return binary
        }() + binary
    }
    return binary
}


