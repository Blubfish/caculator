//
//  Converter.swift
//  Converter
//
//  Created by Damian Myrda on 9/18/23.
//

import SwiftUI

enum From {
    case Decimal
}

enum To {
    case Binary
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
                        Button("Decimal", action: {
                            self.from = .Decimal
                        })
                    }
                    Spacer()
                    Menu("To") {
                        Button("Binary", action: {
                            self.to = .Binary
                        })
                    }
                }
                HStack {
                    TextField({ () -> String in
                        switch self.from {
                        case .Decimal:
                            return "decimal"
                        }
                    }(), text: self.$input)
                    .onSubmit {
                        switch self.from {
                        case .Decimal:
                            switch self.to {
                            case .Binary:
                                self.output = DecimalToBinary(input: self.input)
                            }
                        }
                    }
                    TextField({ () -> String in
                        if output.isEmpty {
                            switch self.to {
                            case .Binary:
                                return "binary"
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
