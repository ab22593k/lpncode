import 'models/lpn_data.dart';

/// Abstract class defining LPN scanning functionality
abstract class LPNScanner {
  /// Scans and parses an LPN barcode
  Future<LPNData?> scan();

  /// Validates if the scanned data matches LPN format
  bool validateScannedData(String rawData);
}

/// Mock implementation for testing purposes
class MockLPNScanner implements LPNScanner {
  @override
  Future<LPNData?> scan() async {
    // Simulated delay
    await Future.delayed(const Duration(seconds: 1));

    return LPNData(
      id: 'ABC123456789',
      createdAt: DateTime.now(),
      locationCode: 'WH-001',
    );
  }

  @override
  bool validateScannedData(String rawData) {
    return rawData.length == 12 && RegExp(r'^[A-Z0-9]+$').hasMatch(rawData);
  }
}
