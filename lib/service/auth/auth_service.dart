import 'dart:convert';
import 'package:crewup_flutter/models/auth/login_request_dto.dart';
import 'package:crewup_flutter/models/auth/signup_request_dto.dart';
import 'package:crewup_flutter/service/auth/jwt_service.dart';
import 'package:crewup_flutter/service/logger_service.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'http://localhost:8080/api/auth';
  final JwtService _jwtService = JwtService();

  Future<Map<String, dynamic>> login(LoginRequestDto request) async {
    final url = Uri.parse('$_baseUrl/sign-in');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String accessToken = data['data']['accessToken'];
        final String refreshToken = data['data']['refreshToken'];

        _jwtService.setJwt(accessToken, refreshToken);

        return data;
      } else {
        return {'error': '로그인에 실패했습니다. 다시 시도해주세요.'};
      }
    } catch (e) {
      return {'error': '로그인 중 오류가 발생했습니다. 다시 시도해주세요.'};
    }
  }

  Future<Map<String, dynamic>> signUp(SignupRequestDto request) async {
    final url = Uri.parse('$_baseUrl/sign-up');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        logger.i(data['data']);

        return data;
      } else {
        return {'error': '회원가입에 실패했습니다. 다시 시도해주세요.'};
      }
    } catch (e) {
      return {'error': '회원가입 중 오류가 발생했습니다. 다시 시도해주세요.'};
    }
  }

  Future<Map<String, dynamic>> reissue() async {
    final url = Uri.parse('$_baseUrl/reissue');

    try {
      final String? refreshToken = await _jwtService.getRefreshToken();

      if (refreshToken == null) {
        return {'error': '리프레시 토큰이 없습니다.'};
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String accessToken = data['data']['accessToken'];
        final String newRefreshToken = data['data']['refreshToken'];

        _jwtService.setJwt(accessToken, newRefreshToken);

        return data;
      } else {
        return {'error': '토큰 갱신에 실패했습니다.'};
      }
    } catch (e) {
      return {'error': '토큰 갱신 중 오류가 발생했습니다.'};
    }
  }
}
