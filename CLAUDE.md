# pwgen — Password Generator CLI

A macOS CLI tool to generate passwords. Built with Swift 6 + swift-argument-parser.

## Project structure

- `Sources/pwgen/PasswordGeneratorCommand.swift` — CLI entry point, flags, run logic
- `Sources/pwgen/PasswordGenerator.swift` — password generation algorithm
- `Sources/pwgen/SymbolType.swift` — character set definitions and similar-chars filter

## CLI design decisions

### Default behavior (no char-type flags)
Running `pwgen -l 20` with no character type flags uses **lowercase + uppercase + numbers**.
Special symbols must be explicitly requested with `-S/--special`.

### Flag conventions
- Short flags use **uppercase** letters for character types to avoid conflict with `-l/--length`
- `-L` lowercase, `-U` uppercase, `-N` numbers, `-S` special
- `--all` enables all four types at once

### Similar character exclusion
Characters that look alike (`0/O`, `l/1/I`) are **excluded by default**.
Use `--include-similar` to allow them.

### Removed from special symbols pool
Backtick, apostrophe, and pipe (`\``, `'`, `|`) are removed entirely from the special symbols
pool — they cause issues in shells and are error-prone when typed manually.

### What was intentionally left out
- No `--count` flag: generate multiple passwords by running the command multiple times
- No `--copy` flag: pipe to `pbcopy` manually — `pwgen -l 20 | pbcopy`
- No presets: keep the interface minimal and composable
