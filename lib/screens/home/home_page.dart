import 'package:flutter/material.dart';
import '../../service/auth/jwt_service.dart';
import '../auth/login_page.dart';

class HomePage extends StatelessWidget {
  final JwtService _jwtService = JwtService();

  void _logout(BuildContext context) async {
    await _jwtService.deleteJwt(); // JWT 토큰 삭제
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()), // 로그인 페이지로 이동
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context), // 로그아웃 버튼 클릭 시
          ),
        ],
      ),
      body: const Center(
        child: Text('홈 페이지에 오신 것을 환영합니다!'),
      ),
    );
  }
}
