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

    @Option
    var symbolTypes: [SymbolType] = [.lowerCaseLetters, .upperCaseLetters, .numbers, .specialSymbols]

    func run() throws {
        let passwordGenerator = PasswordGenerator()
        let password = passwordGenerator.generatePassword(
            symbolTypes: symbolTypes,
            length: length
        )

        print(password)
    }
}
