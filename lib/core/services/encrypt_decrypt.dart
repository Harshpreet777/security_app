import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EncryptDecrypt {
  static String mykey = dotenv.get('MY_KEY');

  static String myiv = dotenv.get('MY_IV');
  static encryptAES({String? uid, String? text}) async {
    final key = encrypt.Key.fromUtf8(mykey);
    final iv = encrypt.IV.fromUtf8(myiv);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, padding: null));
    final encrypted = encrypter.encrypt(text ?? '', iv: iv);
    return encrypted;
  }

  static decryptAES({String? uid, String? text}) async {
    final key = encrypt.Key.fromUtf8(mykey);
    final iv = encrypt.IV.fromUtf8(myiv);
    final decrypter = encrypt.Encrypter(encrypt.AES(key, padding: null));
    final encrypted = encrypt.Encrypted.from64(text ?? '');
    final decrypted = decrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}
