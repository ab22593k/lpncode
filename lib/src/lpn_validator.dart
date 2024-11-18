import 'models/lpn_data.dart';

/// A utility class that provides validation methods for License Plate Number (LPN) data.
///
/// Use this class to validate:
/// - LPN identifier format and structure
/// - Complete LPNData instances
/// - Location codes
/// A utility class that provides validation methods for License Plate Number (LPN) data.
///
/// Use this class to validate:
/// - LPN identifier format and structure
/// - Complete LPNData instances
/// - Location codes
class LPNValidator {
  /// Validates the format of an LPN identifier.
  ///
  /// An LPN identifier must:
  /// - Be exactly 12 characters long
  /// - Contain only uppercase letters (A-Z) and numbers (0-9)
  ///
  /// Example:
  /// ```dart
  /// final validator = LPNValidator();
  /// print(validator.isValidId('ABC123XYZ789')); // true
  /// print(validator.isValidId('abc123')); // false - too short and lowercase
  /// ```
  ///
  /// Returns `true` if the ID is valid, `false` otherwise.
  bool isValidId(String id) {
    if (id.length != 12) return false;
    return RegExp(r'^[A-Z0-9]+$').hasMatch(id);
  }

  /// Validates a complete [LPNData] instance.
  ///
  /// Checks the following conditions:
  /// - The ID must be valid (12 chars, A-Z0-9 only)
  /// - The location code must not be empty
  /// - The creation date must not be in the future
  ///
  /// Example:
  /// ```dart
  /// final validator = LPNValidator();
  /// final data = LPNData(
  ///   id: 'ABC123XYZ789',
  ///   createdAt: DateTime.now(),
  ///   locationCode: 'WH-001',
  /// );
  /// if (validator.isValidLPNData(data)) {
  ///   // Process valid LPN data
  /// }
  /// ```
  ///
  /// Returns `true` if all validation checks pass, `false` otherwise.
  bool isValidLPNData(LPNData data) {
    if (!isValidId(data.id)) return false;
    if (data.locationCode.isEmpty) return false;
    if (DateTime.parse(data.createdAt).isAfter(DateTime.now())) return false;
    return true;
  }

  /// Validates if a location code follows the correct format.
  ///
  /// A valid location code must:
  /// - Not be empty
  /// - Follow the pattern: WH-XXX where X is any alphanumeric character
  ///
  /// Example:
  /// ```dart
  /// final validator = LPNValidator();
  /// print(validator.isValidLocationCode('WH-001')); // true
  /// print(validator.isValidLocationCode('INVALID')); // false
  /// ```
  bool isValidLocationCode(String code) {
    if (code.isEmpty) return false;
    return RegExp(r'^WH-[A-Z0-9]{3}$').hasMatch(code);
  }
}
