# LPNCode

A Flutter package for generating, scanning, and managing License Plate Number (LPN) barcodes in warehouse management systems. This package provides utilities for creating unique LPN identifiers, scanning barcodes, and validating LPN data.

[![pub package](https://img.shields.io/pub/v/lpncode.svg)](https://pub.dev/packages/lpncode)
[![Build Status](https://github.com/ab22593k/lpncode/workflows/CI/badge.svg)](https://github.com/ab22593k/lpncode/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

- 🏷️ Generate unique LPN identifiers with configurable formats
- 📱 Scan and parse LPN barcodes
- ✅ Validate LPN data and formats
- 🔄 Convert LPN data to/from JSON
- 📦 Store additional metadata with LPNs
- 🧪 Mock scanner implementation for testing

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  lpncode: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Generating LPNs

```dart
import 'package:lpncode/lpncode.dart';

void main() {
  final generator = LPNGenerator();

  // Generate a simple LPN
  final lpn = generator.generateLPN(
    locationCode: 'WH-001',
  );
  print('Generated LPN: ${lpn.id}');

  // Generate LPN with metadata
  final lpnWithMeta = generator.generateLPN(
    locationCode: 'WH-002',
    metadata: {
      'product': 'Electronics',
      'quantity': 50,
    },
  );
}
```

### Scanning LPNs

```dart
import 'package:lpncode/lpncode.dart';

Future<void> scanExample() async {
  final scanner = MockLPNScanner();

  final scannedLPN = await scanner.scan();
  if (scannedLPN != null) {
    print('Scanned LPN ID: ${scannedLPN.id}');
    print('Location: ${scannedLPN.locationCode}');
  }
}
```

### Validating LPNs

```dart
import 'package:lpncode/lpncode.dart';

void validateExample() {
  final validator = LPNValidator();
  final lpnData = LPNData(
    id: 'ABC123456789',
    createdAt: DateTime.now(),
    locationCode: 'WH-001',
  );

  if (validator.isValidLPNData(lpnData)) {
    print('LPN data is valid');
  }
}
```

### Working with LPN Data

```dart
import 'package:lpncode/lpncode.dart';

void dataExample() {
  // Create LPN data
  final lpnData = LPNData(
    id: 'ABC123456789',
    createdAt: DateTime.now(),
    locationCode: 'WH-001',
    metadata: {'category': 'Electronics'},
  );

  // Convert to JSON
  final json = lpnData.toJson();

  // Create from JSON
  final reconstructed = LPNData.fromJson(json);
}
```

## LPN Format

By default, LPNs are generated with the following format:
- 12 characters long
- Consists of uppercase letters (A-Z) and numbers (0-9)
- Example: `ABC123XYZ789`

## Documentation

For detailed API documentation, please visit:
- [API Reference](https://pub.dev/documentation/lpncode/latest/)
- [Examples](https://github.com/ab22593k/lpncode/tree/main/example)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions:
1. Check existing [GitHub Issues](https://github.com/ab22593k/lpncode/issues)
2. Create a new issue if needed
3. Reach out to the maintainers
