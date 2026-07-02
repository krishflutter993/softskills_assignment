import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EncryptionService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const String _keyName = 'encryption_key';
  encrypt.Key? _encryptionKey;

  Future<void> init() async {
    String? storedKey = await _secureStorage.read(key: _keyName);
    if (storedKey == null) {
      final key = encrypt.Key.fromSecureRandom(32);
      await _secureStorage.write(key: _keyName, value: key.base64);
      _encryptionKey = key;
    } else {
      _encryptionKey = encrypt.Key.fromBase64(storedKey);
    }
  }

  String encryptPassword(String plainText) {
    if (_encryptionKey == null) throw Exception('EncryptionService not initialized');
    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(_encryptionKey!));
    
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    
    // Combine IV and encrypted data
    return '${iv.base64}:${encrypted.base64}';
  }

  String decryptPassword(String encryptedData) {
    if (_encryptionKey == null) throw Exception('EncryptionService not initialized');
    
    final parts = encryptedData.split(':');
    if (parts.length != 2) throw Exception('Invalid encrypted data format');
    
    final iv = encrypt.IV.fromBase64(parts[0]);
    final encrypted = encrypt.Encrypted.fromBase64(parts[1]);
    
    final encrypter = encrypt.Encrypter(encrypt.AES(_encryptionKey!));
    return encrypter.decrypt(encrypted, iv: iv);
  }

  String hashMasterPassword(String masterPassword) {
    var bytes = utf8.encode(masterPassword);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
