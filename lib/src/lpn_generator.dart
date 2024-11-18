import 'dart:math';
import 'models/lpn_data.dart';

/// A utility class that generates License Plate Number (LPN) barcodes for warehouse management.
///
/// This class provides methods to:
/// - Generate unique 12-character LPN identifiers
/// - Create complete LPNData instances with timestamps
/// - Support custom metadata for tracking additional information
///
/// The generated LPNs follow a standardized format of uppercase letters and numbers.
class LPNGenerator {
  final Random _random = Random();

  /// Generates a new unique LPN identifier.
  ///
  /// Creates a 12-character string consisting of:
  /// - Uppercase letters (A-Z)
  /// - Numbers (0-9)
  ///
  /// Example:
  /// ```dart
  /// final generator = LPNGenerator();
  /// final id = generator.generateId(); // e.g. "ABC123XYZ789"
  /// ```
  ///
  /// Returns a randomly generated identifier that matches the LPN format.
  String generateId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(12, (index) {
      return chars[_random.nextInt(chars.length)];
    }).join();
  }

  /// Creates a new [LPNData] instance with a randomly generated ID.
  ///
  /// Parameters:
  /// - [locationCode]: The warehouse location code (e.g. "WH-001")
  /// - [metadata]: Optional key-value pairs for additional data tracking
  ///
  /// Example:
  /// ```dart
  /// final generator = LPNGenerator();
  /// final lpn = generator.generateLPN(
  ///   locationCode: 'WH-001',
  ///   metadata: {'product': 'Electronics', 'quantity': 50},
  /// );
  /// ```
  ///
  /// Returns a new [LPNData] instance with the current timestamp.
  LPNData generateLPN({
    required String locationCode,
    Map<String, String> metadata = const {},
  }) {
    return LPNData(
      id: generateId(),
      createdAt: DateTime.now().toString(),
      locationCode: locationCode,
      metadata: metadata,
    );
  }
}
