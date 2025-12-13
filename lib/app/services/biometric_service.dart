import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

/// Service for handling biometric authentication
class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  /// Check if biometric authentication is available on this device
  Future<bool> canCheckBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  /// Check if device has biometric hardware
  Future<bool> isDeviceSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } on PlatformException {
      return false;
    }
  }

  /// Get list of available biometric types on this device
  /// Returns: [BiometricType.face, BiometricType.fingerprint, etc.]
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException {
      return <BiometricType>[];
    }
  }

  /// Check if Face ID is available
  Future<bool> hasFaceID() async {
    final biometrics = await getAvailableBiometrics();
    return biometrics.contains(BiometricType.face);
  }

  /// Check if fingerprint is available
  Future<bool> hasFingerprint() async {
    final biometrics = await getAvailableBiometrics();
    return biometrics.contains(BiometricType.fingerprint);
  }

  /// Authenticate user with biometrics
  /// 
  /// [localizedReason] - Message shown to user explaining why authentication is needed
  /// [biometricOnly] - If true, only allow biometric (no PIN/password fallback)
  /// 
  /// Returns true if authentication successful, false otherwise
  Future<BiometricAuthResult> authenticate({
    required String localizedReason,
    bool biometricOnly = true,
  }) async {
    try {
      // Check if biometrics are available
      final canCheck = await canCheckBiometrics();
      if (!canCheck) {
        return BiometricAuthResult(
          success: false,
          errorType: BiometricErrorType.notAvailable,
          errorMessage: 'Biometric authentication is not available on this device',
        );
      }

      // Check if any biometrics are enrolled
      final availableBiometrics = await getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        return BiometricAuthResult(
          success: false,
          errorType: BiometricErrorType.notEnrolled,
          errorMessage: 'No biometrics enrolled. Please set up Face ID or fingerprint in device settings',
        );
      }

      // Attempt authentication
      final authenticated = await _auth.authenticate(
        localizedReason: localizedReason,
        options: AuthenticationOptions(
          biometricOnly: biometricOnly,
          stickyAuth: true,
        ),
      );

      return BiometricAuthResult(
        success: authenticated,
        errorType: authenticated ? null : BiometricErrorType.authFailed,
        errorMessage: authenticated ? null : 'Authentication failed',
      );
    } on PlatformException catch (e) {
      // Handle specific error codes
      if (e.code == auth_error.notAvailable) {
        return BiometricAuthResult(
          success: false,
          errorType: BiometricErrorType.notAvailable,
          errorMessage: 'Biometric authentication is not available',
        );
      } else if (e.code == auth_error.notEnrolled) {
        return BiometricAuthResult(
          success: false,
          errorType: BiometricErrorType.notEnrolled,
          errorMessage: 'No biometrics enrolled on this device',
        );
      } else if (e.code == auth_error.lockedOut || e.code == auth_error.permanentlyLockedOut) {
        return BiometricAuthResult(
          success: false,
          errorType: BiometricErrorType.lockedOut,
          errorMessage: 'Too many failed attempts. Biometric authentication is temporarily locked',
        );
      } else if (e.code == auth_error.passcodeNotSet) {
        return BiometricAuthResult(
          success: false,
          errorType: BiometricErrorType.passcodeNotSet,
          errorMessage: 'Please set up a passcode on your device first',
        );
      }

      // User cancelled or other error
      return BiometricAuthResult(
        success: false,
        errorType: BiometricErrorType.userCancelled,
        errorMessage: e.message ?? 'Authentication cancelled',
      );
    } catch (e) {
      return BiometricAuthResult(
        success: false,
        errorType: BiometricErrorType.unknown,
        errorMessage: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  /// Stop authentication (if in progress)
  Future<void> stopAuthentication() async {
    try {
      await _auth.stopAuthentication();
    } catch (e) {
      // Ignore errors when stopping
    }
  }
}

/// Result of biometric authentication attempt
class BiometricAuthResult {
  final bool success;
  final BiometricErrorType? errorType;
  final String? errorMessage;

  BiometricAuthResult({
    required this.success,
    this.errorType,
    this.errorMessage,
  });

  bool get isNotAvailable => errorType == BiometricErrorType.notAvailable;
  bool get isNotEnrolled => errorType == BiometricErrorType.notEnrolled;
  bool get isLockedOut => errorType == BiometricErrorType.lockedOut;
  bool get isUserCancelled => errorType == BiometricErrorType.userCancelled;
}

/// Types of biometric authentication errors
enum BiometricErrorType {
  notAvailable,
  notEnrolled,
  lockedOut,
  passcodeNotSet,
  authFailed,
  userCancelled,
  unknown,
}
