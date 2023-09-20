

import SwiftUI
struct BinaryToDecimal: View {
    @State var input: String = ""
    @State var binary: [Int] = []
    @State var powernum: Double = 0.0
    @State var output: String = ""
    var body: some View {
        TextField("Type binary ", text: self.$input)
            .onSubmit {
                self.binary = []
                for bit in self.input {
                    self.binary.append({ () -> Int in
                        if let bit = Int(String(bit)) {
                            if bit > 1 || bit < 0 {
                                return 0
                            }
                            return bit
                        } else {
                            return 0
                        }
                    }())
                }
                self.binary = self.binary.reversed()
                var position = 0.0
                var answer = 0
                for num in self.binary {
                    if num == 1 {
                        answer += Int(pow(2.0, position))
                    }
                    position += 1
                }
                self.output = String(answer)
            }
            .foregroundColor(.blue)
            .frame(width: 100, height: 0, alignment: .center)
        Text("Decimal: ")
        + Text(self.output)
        
    }
        
                
}
