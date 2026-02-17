import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage datasource for sensitive credentials
///
/// Uses platform-specific secure storage:
/// - macOS/iOS: Keychain
/// - Android: EncryptedSharedPreferences
/// - Linux: libsecret (GNOME Keyring/KWallet)
/// - Windows: Windows Credential Manager
///
/// Stores:
/// - Bearer tokens for ZeroClaw gateway authentication
/// - Encryption keys for Hive encrypted boxes
class SecureStorageDatasource {
  final FlutterSecureStorage _secureStorage;

  SecureStorageDatasource({FlutterSecureStorage? secureStorage})
    : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  /// Storage keys
  static const String _bearerTokenKey = 'bearer_token';
  static const String _gatewayUrlKey = 'gateway_url';
  static const String _providerTypeKey = 'provider_type';
  static const String _encryptionKeyKey = 'encryption_key';

  /// Store bearer token securely
  Future<void> storeBearerToken(String token) async {
    await _secureStorage.write(key: _bearerTokenKey, value: token);
  }

  /// Retrieve bearer token securely
  Future<String?> getBearerToken() async {
    return await _secureStorage.read(key: _bearerTokenKey);
  }

  /// Clear bearer token
  Future<void> clearBearerToken() async {
    await _secureStorage.delete(key: _bearerTokenKey);
  }

  /// Store gateway URL
  Future<void> storeGatewayUrl(String url) async {
    await _secureStorage.write(key: _gatewayUrlKey, value: url);
  }

  /// Retrieve gateway URL
  Future<String?> getGatewayUrl() async {
    return await _secureStorage.read(key: _gatewayUrlKey);
  }

  /// Clear gateway URL
  Future<void> clearGatewayUrl() async {
    await _secureStorage.delete(key: _gatewayUrlKey);
  }

  /// Store provider type
  Future<void> storeProviderType(String providerType) async {
    await _secureStorage.write(key: _providerTypeKey, value: providerType);
  }

  /// Retrieve provider type
  Future<String?> getProviderType() async {
    return await _secureStorage.read(key: _providerTypeKey);
  }

  /// Clear provider type
  Future<void> clearProviderType() async {
    await _secureStorage.delete(key: _providerTypeKey);
  }

  /// Store encryption key for Hive encrypted boxes
  Future<void> storeEncryptionKey(String key) async {
    await _secureStorage.write(key: _encryptionKeyKey, value: key);
  }

  /// Retrieve encryption key
  Future<String?> getEncryptionKey() async {
    return await _secureStorage.read(key: _encryptionKeyKey);
  }

  /// Clear all stored data
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
