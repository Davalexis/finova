import 'dart:convert';               // For utf8 encoding
import 'package:crypto/crypto.dart';  // For sha256 

class PinHasher{
  PinHasher._();

  static const String _salt = "";

  static String hashPin(String pin ){
    final String saltedPin = pin + _salt;
    final List<int> bytes = utf8.encode(saltedPin);
    final Digest digest = sha256.convert(bytes);

    return digest.toString();
  }

  static bool verifyPin( String pin , String hashedPin){
      final String newHash = hashPin(pin);
    return newHash == hashedPin; 
  }
}