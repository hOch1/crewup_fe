import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtService {
  final _secureStorage = const FlutterSecureStorage();

  final String _accessTokenKey = 'access_token';
  final String _refreshTokenKey = 'refresh_token';

  Future<void> setJwt(String accessToken, String refreshToken) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  Future<void> deleteJwt() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }
}
