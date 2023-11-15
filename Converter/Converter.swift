import SwiftUI

enum From {
    case Binary
    case Decimal
    case Hexadecimal
    
    func name() -> String {
        switch self {
        case .Binary:
            return "binary"
        case .Decimal:
            return "decimal"
        case .Hexadecimal:
            return "hexadecimal"
        }
    }
}

enum To {
    case Binary
    case Decimal
    case Hexadecimal
    
    func name() -> String {
        switch self {
        case .Binary:
            return "binary"
        case .Decimal:
            return "decimal"
        case .Hexadecimal:
            return "hexadecimal"
        }
    }
}

enum Endianess {
    case Little
    case Big
    
    func name() -> String {
        switch self {
        case .Big:
            return "big"
        case .Little:
            return "little"
        }
    }
}

@main
struct Converter: App {
    @State var endianess: Endianess = .Big
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
            if self.endianess == .Little {
                self.binary = self.binary.reversed()
            }
        case .Decimal:
            if let decimal = Int(self.input) {
                self.binary = DecimalToBinary(decimal: decimal)
            }
        case .Hexadecimal:
            self.binary = HexadecimalToBinary(hexadecimal: self.input)
        }
    }
    
    func display() {
        self.output = ""
        switch self.to {
        case .Binary:
            switch self.endianess {
            case .Big:
                for bit in self.binary.reversed() {
                    if bit {
                        self.output += "1"
                    } else {
                        self.output += "0"
                    }
                }
            case .Little:
                for bit in self.binary {
                    if bit {
                        self.output += "1"
                    } else {
                        self.output += "0"
                    }
                }
            }
        case .Decimal:
            self.output = String(BinaryToDecimal(binary: self.binary))
        case .Hexadecimal:
            self.output = BinaryToHexadecimal(binary: self.binary)
        }
    }
    
    func update() {
        self.parse()
        self.display()
    }
    
    var body: some Scene {
        WindowGroup {
            VStack {
                HStack {
                    Menu("From") {
                        Button("Binary", action: {
                            self.from = .Binary
                            self.update()
                        })
                        Button("Decimal", action: {
                            self.from = .Decimal
                            self.update()
                        })
                        Button("Hexadecimal", action: {
                            self.from = .Hexadecimal
                            self.update()
                        })
                    }
                    .multilineTextAlignment(.leading)
                    Spacer()
                    Menu("Endianess") {
                        Button("Little", action: {
                            self.endianess = .Little
                            self.update()
                        })
                        Button("Big", action: {
                            self.endianess = .Big
                            self.update()
                        })
                    }
                    .multilineTextAlignment(.center)
                    Spacer()
                    Menu("To") {
                        Button("Binary", action: {
                            self.to = .Binary
                            self.update()
                        })
                        Button("Decimal", action: {
                            self.to = .Decimal
                            self.update()
                        })
                        Button("Hexadecimal", action: {
                            self.to = .Hexadecimal
                            self.update()
                        })
                    }
                    .multilineTextAlignment(.trailing)
                }
                HStack {
                    TextField(self.from.name(), text: self.$input)
                    .onSubmit {
                        self.update()
                    }
                    TextField({ () -> String in
                        if output.isEmpty {
                            return self.to.name()
                        }
                        return self.output
                    }(), text: self.$output)
                    .multilineTextAlignment(.trailing)
                    .disabled(true)
                }
                Button("Convert", action: {() -> Void in
                    self.update()
                })
            }
            .padding()
        }
    }
}
