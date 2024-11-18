import 'package:json/json.dart';

/// Represents the data structure of a License Plate Number (LPN) barcode used in warehouse management.
///
/// Each LPN consists of:
/// - A unique 12-character alphanumeric identifier
/// - Creation timestamp
/// - Location code in WH-XXX format
/// - Optional metadata key-value pairs
///
/// Example:
/// ```dart
/// final lpn = LPNData(
///   id: 'ABC123XYZ789',
///   createdAt: DateTime.now(),
///   locationCode: 'WH-001',
///   metadata: {'category': 'Electronics'},
/// );
/// ```
@JsonCodable()
class LPNData {
  /// Unique identifier for the LPN
  final String id;

  /// Timestamp when the LPN was created
  final String createdAt;

  /// Location code where the LPN was generated
  final String locationCode;

  /// Additional metadata associated with the LPN
  final Map<String, String> metadata;

  const LPNData({
    required this.id,
    required this.createdAt,
    required this.locationCode,
    this.metadata = const {},
  });
}
