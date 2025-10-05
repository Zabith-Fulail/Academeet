import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
const String accessToken = 'access_token';
class LocalDataSource {
  FlutterSecureStorage? secureStorage;
  SharedPreferences? prefs;

  LocalDataSource({this.secureStorage, this.prefs});

  void setAccessToken(String? token) {
    secureStorage!.write(key: accessToken, value: token);
  }

  Future<String?> getAccessToken() async {
    return secureStorage!.read(key: accessToken);
  }

  void clearAccessToken() {
    secureStorage!.delete(key: accessToken);
  }
}