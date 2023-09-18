//
//  DecimalToBinary.swift
//  Converter
//
//  Created by Damian Myrda on 9/18/23.
//

import SwiftUI

struct DecimalToBinary: View {
    @State var input: String = ""
    @State var binary: [Int] = []
    
    var body: some View {
        TextField("decimal", text: self.$input)
            .onSubmit {
                self.binary = []
                var decimal = { () -> Int in
                    if let decimal = Int(self.input) {
                        return decimal
                    } else {
                        return 0
                    }
                }()
                var place = 0
                while decimal > 0 {
                    let bit = decimal % 2
                    self.binary.append(bit)
                    place += 1
                    decimal = decimal / 2
                }
            }
        Text({ () -> String in
            var text = ""
            for bit in binary.reversed() {
                text += String(bit)
            }
            return text
        }())
    }
}
