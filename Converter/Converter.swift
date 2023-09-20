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
    @State var output: String = ""
    
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
                        switch self.from {
                        case.Binary:
                            switch self.to {
                            case .Binary:
                                self.output = self.input
                            case .Decimal:
                                self.output = BinaryToDecimal(input: self.input)
                            }
                        case .Decimal:
                            switch self.to {
                            case .Binary:
                                self.output = DecimalToBinary(input: self.input)
                            case .Decimal:
                                self.output = self.input
                            }
                        }
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
