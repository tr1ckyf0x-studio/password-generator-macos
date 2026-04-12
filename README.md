# pwgen

A minimal CLI password generator for macOS.

## Installation

### Via Mint

```bash
mint install tr1ckyf0x-studio/password-generator-macos
```

### Manual

```bash
swift build -c release
cp .build/release/pwgen /usr/local/bin/pwgen
```

## Usage

```bash
pwgen -l <length> [options]
```

### Options

| Flag | Short | Description |
|------|-------|-------------|
| `--length` | `-l` | Password length (required) |
| `--lowercase` | `-L` | Use lowercase letters (a–z) |
| `--uppercase` | `-U` | Use uppercase letters (A–Z) |
| `--numbers` | `-N` | Use digits (0–9) |
| `--special` | `-S` | Use special symbols |
| `--all` | — | Use all character types |
| `--include-similar` | — | Allow visually similar characters (0/O, l/1/I) |

### Default behavior

Running `pwgen -l 20` without any character type flags generates a password using
**lowercase + uppercase + numbers**, with visually similar characters excluded.

Special symbols must be explicitly requested with `-S` or `--all`.

### Examples

```bash
# Default: lower + upper + numbers, no ambiguous chars
pwgen -l 20

# Add special symbols
pwgen -l 20 -S

# Everything
pwgen -l 20 --all

# PIN (digits only)
pwgen -l 6 -N

# Allow similar characters
pwgen -l 20 --include-similar

# Copy to clipboard
pwgen -l 20 | pbcopy
```
