import ArgumentParser

@main
struct PasswordGeneratorCommand: ParsableCommand {

    public static let configuration = CommandConfiguration(
        commandName: "pwgen",
        abstract: "Generates password",
        version: "1.0.0"
    )

    @Option(name: [.short, .long], help: "Length of the password")
    var length: UInt

    @Flag(name: [.long], help: "Use lowercase letters")
    var lowercase: Bool = false

    @Flag(name: [.long], help: "Use uppercase letters")
    var uppercase: Bool = false

    @Flag(name: [.long], help: "Use numbers")
    var numbers: Bool = false
    
    @Flag(name: [.short, .long], help: "Use special symbols")
    var special: Bool = false

    @Flag(name: [.long], help: "Use default character set: lowercase, uppercase, numbers, special symbols")
    var `default`: Bool = false

    @Flag(name: [.customLong("no-special")], help: "Do not use special symbols")
    var noSpecialSymbols: Bool = false

    func run() throws {

        var symbols = [
            SymbolType.lowerCaseLetters: lowercase,
            SymbolType.upperCaseLetters: uppercase,
            SymbolType.numbers: numbers,
            SymbolType.specialSymbols: special
        ]

        if `default` {
            symbols.keys.forEach { symbols[$0] = true }
        }

        if noSpecialSymbols {
            symbols[.specialSymbols] = false
        }

        let symbolTypes = symbols
            .filter { _, isIncluded in isIncluded }
            .map { symbolType, _ in symbolType }

        if symbolTypes.isEmpty {
            throw CleanExit.helpRequest(Self.self)
        }

        let passwordGenerator = PasswordGenerator()
        let password = passwordGenerator.generatePassword(
            symbolTypes: symbolTypes,
            length: length
        )

        print(password)
    }
}
