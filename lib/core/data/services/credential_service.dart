import 'dart:convert'; // Para utf8
import 'dart:html' as html; // Para localStorage
import 'dart:math'; // Para generar IV aleatorio
import 'dart:typed_data'; // Para Uint8List
import 'package:webcrypto/webcrypto.dart';

class CredentialService {
  // Claves para localStorage
  static const _storageKeyCipher = 'app_encrypted_credentials';
  static const _storageKeyIv = 'app_aes_gcm_iv';
  static const _storageKeyRawKey = 'app_raw_key'; // OJO: Guardar la key no es seguro

  // Longitud típica para IV (nonce) en AES-GCM
  static const int _ivLength = 12;

  /// Retorna (o genera) una clave AES-GCM de 256 bits.
  /// *En producción*, evita guardar la clave en localStorage.
  Future<AesGcmSecretKey> _getOrCreateKey() async {
    final storedRawKey = html.window.localStorage[_storageKeyRawKey];
    if (storedRawKey != null) {
      // Recuperar la clave en Base64
      final rawBytes = base64.decode(storedRawKey);
      return AesGcmSecretKey.importRawKey(rawBytes);
    } else {
      // Generar nueva clave
      final key = await AesGcmSecretKey.generateKey(256);
      // Exportarla a bytes crudos
      final rawKey = await key.exportRawKey();
      // Guardarla en localStorage (Base64)
      html.window.localStorage[_storageKeyRawKey] = base64.encode(rawKey);
      return key;
    }
  }

  /// Cifra y almacena las credenciales (email, password) en localStorage.
  Future<void> storeCredentials(String email, String password) async {
    final key = await _getOrCreateKey();
    // Generar un IV aleatorio
    final iv = _generateRandomIv(_ivLength);

    // Crear el plaintext
    final plaintext = utf8.encode('$email:$password');

    // Cifrar con AES-GCM (usando iv como segundo argumento)
    final cipherBytes = await key.encryptBytes(
      plaintext,
      iv,
      // additionalData: opcional
      // tagLength: opcional (por defecto 128)
    );

    // Guardar en localStorage
    html.window.localStorage[_storageKeyCipher] = base64.encode(cipherBytes);
    html.window.localStorage[_storageKeyIv] = base64.encode(iv);
  }

  /// Recupera y descifra las credenciales, o null si no existen.
  Future<Map<String, String>?> getCredentials() async {
    final cipherBase64 = html.window.localStorage[_storageKeyCipher];
    final ivBase64 = html.window.localStorage[_storageKeyIv];

    // Si faltan datos, no hay credenciales
    if (cipherBase64 == null || ivBase64 == null) {
      return null;
    }

    // Decodificar
    final cipherBytes = base64.decode(cipherBase64);
    final iv = base64.decode(ivBase64);

    final key = await _getOrCreateKey();
    try {
      // Descifrar
      final decryptedBytes = await key.decryptBytes(cipherBytes, iv);
      final decryptedStr = utf8.decode(decryptedBytes);
      // Asumimos formato "email:password"
      final parts = decryptedStr.split(':');
      if (parts.length == 2) {
        return {
          'email': parts[0],
          'password': parts[1],
        };
      }
    } catch (_) {
      // Error al descifrar
      return null;
    }
    return null;
  }

  /// Borra las credenciales guardadas.
  Future<void> clearCredentials() async {
    html.window.localStorage.remove(_storageKeyCipher);
    html.window.localStorage.remove(_storageKeyIv);
    // Si quisieras forzar regenerar la clave, borra también la rawKey:
    // html.window.localStorage.remove(_storageKeyRawKey);
  }

  /// Genera un IV aleatorio para AES-GCM.
  Uint8List _generateRandomIv(int length) {
    final rand = Random.secure();
    final bytes = List<int>.generate(length, (_) => rand.nextInt(256));
    return Uint8List.fromList(bytes);
  }
}
