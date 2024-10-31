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
class LPNData {
  /// Unique identifier for the LPN
  final String id;

  /// Timestamp when the LPN was created
  final DateTime createdAt;

  /// Location code where the LPN was generated
  final String locationCode;

  /// Additional metadata associated with the LPN
  final Map<String, dynamic> metadata;

  const LPNData({
    required this.id,
    required this.createdAt,
    required this.locationCode,
    this.metadata = const {},
  });

  /// Creates an LPNData instance from a JSON map
  factory LPNData.fromJson(Map<String, dynamic> json) {
    return LPNData(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      locationCode: json['locationCode'] as String,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  /// Converts the LPNData instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'locationCode': locationCode,
      'metadata': metadata,
    };
  }
}
