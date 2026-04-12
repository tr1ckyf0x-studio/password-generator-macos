import ArgumentParser

@main
struct PasswordGeneratorCommand: ParsableCommand {

    public static let configuration = CommandConfiguration(
        commandName: "pwgen",
        abstract: "Generates password",
        version: "1.1.0"
    )

    @Option(name: [.short, .long], help: "Length of the password")
    var length: UInt

    @Flag(name: [.customShort("L"), .long], help: "Use lowercase letters")
    var lowercase: Bool = false

    @Flag(name: [.customShort("U"), .long], help: "Use uppercase letters")
    var uppercase: Bool = false

    @Flag(name: [.customShort("N"), .long], help: "Use numbers")
    var numbers: Bool = false

    @Flag(name: [.customShort("S"), .long], help: "Use special symbols")
    var special: Bool = false

    @Flag(name: [.long], help: "Use all character types")
    var all: Bool = false

    @Flag(name: .long, help: "Allow visually similar characters (0/O, l/1/I)")
    var includeSimilar: Bool = false

    func run() throws {
        guard length > 0 else {
            throw ValidationError("Length must be greater than 0")
        }

        let anyExplicit = lowercase || uppercase || numbers || special || all

        var symbols: [SymbolType: Bool] = [
            .lowerCaseLetters: anyExplicit ? lowercase : true,
            .upperCaseLetters: anyExplicit ? uppercase : true,
            .numbers:          anyExplicit ? numbers   : true,
            .specialSymbols:   anyExplicit ? special   : false,
        ]

        if all {
            symbols.keys.forEach { symbols[$0] = true }
        }

        let symbolTypes = symbols
            .filter { _, isIncluded in isIncluded }
            .map { symbolType, _ in symbolType }

        let passwordGenerator = PasswordGenerator()
        let password = passwordGenerator.generatePassword(
            symbolTypes: symbolTypes,
            length: length,
            includeSimilar: includeSimilar
        )

        print(password)
    }
}
