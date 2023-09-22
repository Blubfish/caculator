import SwiftUI

enum From {
    case Binary
    case Decimal
}

enum To {
    case Binary
    case Decimal
}

@main
struct Converter: App {
    @State var from: From = .Decimal
    @State var to: To = .Binary
    @State var input: String = ""
    @State var binary: [Bool] = [] // big endian
    @State var output: String = ""
    
    func parse() {
        self.binary = []
        switch self.from {
        case.Binary:
            for bit in self.input.reversed() {
                if let bit = Int(String(bit)) {
                    if bit == 0 {
                        self.binary.append(false)
                    } else if bit == 1 {
                        self.binary.append(true)
                    }
                }
            }
        case .Decimal:
            if let decimal = Int(self.input) {
                self.binary = DecimalToBinary(decimal: decimal)
            }
        }
    }
    
    func display() {
        self.output = ""
        switch self.to {
        case .Binary:
            for bit in self.binary.reversed() {
                if bit {
                    self.output += "1"
                } else {
                    self.output += "0"
                }
            }
        case .Decimal:
            self.output = String(BinaryToDecimal(binary: self.binary))
        }
    }
    
    var body: some Scene {
        WindowGroup {
            VStack {
                HStack {
                    Menu("From") {
                        Button("Binary", action: {
                            self.from = .Binary
                        })
                        Button("Decimal", action: {
                            self.from = .Decimal
                        })
                    }
                    Spacer()
                    Menu("To") {
                        Button("Binary", action: {
                            self.to = .Binary
                        })
                        Button("Decimal", action: {
                            self.to = .Decimal
                        })
                    }
                }
                HStack {
                    TextField({ () -> String in
                        switch self.from {
                        case .Binary:
                            return "binary"
                        case .Decimal:
                            return "decimal"
                        }
                    }(), text: self.$input)
                    .onSubmit {
                        self.parse()
                        self.display()
                    }
                    TextField({ () -> String in
                        if output.isEmpty {
                            switch self.to {
                            case .Binary:
                                return "binary"
                            case .Decimal:
                                return "decimal"
                            }
                        }
                        return self.output
                    }(), text: self.$output)
                    .multilineTextAlignment(.trailing)
                    .disabled(true)
                }
            }
            .padding()
        }
    }
}
