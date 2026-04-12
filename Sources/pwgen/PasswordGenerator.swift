//
//  PasswordGenerator.swift
//
//
//  Created by Vladislav Lisianskii on 02.03.2024.
//

import Foundation

protocol GeneratesPassword {
    func generatePassword(symbolTypes: [SymbolType], length: UInt, includeSimilar: Bool) -> String
}

struct PasswordGenerator {
    private let symbolRangeStringFactory: GeneratesSymbolRangeString

    init(
        symbolRangeStringFactory: GeneratesSymbolRangeString = SymbolType.RangeStringFactory()
    ) {
        self.symbolRangeStringFactory = symbolRangeStringFactory
    }
}

// MARK: - GeneratesPassword

extension PasswordGenerator: GeneratesPassword {
    func generatePassword(
        symbolTypes: [SymbolType],
        length: UInt,
        includeSimilar: Bool
    ) -> String {
        var pool = symbolTypes
            .map(symbolRangeStringFactory.string(for:))
            .joined()

        if !includeSimilar {
            pool = pool.filter { !SymbolType.similarCharacters.contains($0) }
        }

        return (0..<length)
            .lazy
            .compactMap { (_: UInt) -> Character? in
                pool.randomElement()
            }
            .map(String.init)
            .joined()
    }
}
