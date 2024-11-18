import 'package:test/test.dart';
import 'package:lpncode/lpncode.dart';

void main() {
  group('LPNGenerator', () {
    final generator = LPNGenerator();

    test('generates valid LPN IDs', () {
      final id = generator.generateId();
      expect(id.length, equals(12));
      expect(RegExp(r'^[A-Z0-9]+$').hasMatch(id), isTrue);
    });

    test('generates valid LPNData', () {
      final lpn = generator.generateLPN(locationCode: 'WH-001');
      expect(lpn.locationCode, equals('WH-001'));
      expect(lpn.id.length, equals(12));
    });
  });

  group('LPNValidator', () {
    final validator = LPNValidator();

    test('validates LPN ID format', () {
      expect(validator.isValidId('ABC123456789'), isTrue);
      expect(validator.isValidId('123'), isFalse);
      expect(validator.isValidId('abc123456789'), isFalse);
    });

    test('validates LPNData', () {
      final validLPN = LPNData(
        id: 'ABC123456789',
        createdAt: DateTime.now().toString(),
        locationCode: 'WH-001',
      );
      expect(validator.isValidLPNData(validLPN), isTrue);

      final invalidLPN = LPNData(
        id: '123',
        createdAt: DateTime.now().toString(),
        locationCode: '',
      );
      expect(validator.isValidLPNData(invalidLPN), isFalse);
    });
  });

  group('LPNScanner', () {
    final scanner = MockLPNScanner();

    test('validates scanned data format', () {
      expect(scanner.validateScannedData('ABC123456789'), isTrue);
      expect(scanner.validateScannedData('123'), isFalse);
    });

    test('can scan and return LPNData', () async {
      final result = await scanner.scan();
      expect(result, isNotNull);
      expect(result?.id.length, equals(12));
      expect(result?.locationCode, isNotEmpty);
    });
  });
}
