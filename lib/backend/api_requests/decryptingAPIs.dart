import 'dart:convert';
import 'package:cryptography/cryptography.dart';

Future<String> decryptAESGCM(String base64CipherText, String keyBase64) async {
  // Decode the Base64-encoded ciphertext to get the original bytes (IV | ciphertext | MAC)
  List<int> cipherBytes = base64.decode(base64CipherText);

  // Print the length of the decoded bytes for debugging
  print("Length of decoded bytes: ${cipherBytes.length}");

  // Ensure the cipherBytes has enough data
  if (cipherBytes.length < 28) { // 12 bytes IV + 16 bytes MAC
    throw Exception('Invalid ciphertext length.');
  }

  // Decode the Base64 key
  List<int> passphrase = base64.decode(keyBase64);

  // Create the secret key
  SecretKey secretKey = SecretKey(passphrase);

  // Extract the IV, ciphertext, and MAC
  final iv = cipherBytes.sublist(0, 12); // First 12 bytes for IV
  final mac = cipherBytes.sublist(cipherBytes.length - 16); // Last 16 bytes for MAC
  final ciphertext = cipherBytes.sublist(12, cipherBytes.length - 16); // Middle part for ciphertext

  // Create a SecretBox with the extracted parts
  SecretBox secretBox = SecretBox(ciphertext, nonce: iv, mac: Mac(mac));

  // Decrypt the data
  List<int> decryptedBytes = await AesGcm.with256bits().decrypt(
    secretBox,
    secretKey: secretKey,
  );

  // Convert the decrypted bytes back to a string
  String decryptedText = utf8.decode(decryptedBytes);
  return decryptedText;
}

