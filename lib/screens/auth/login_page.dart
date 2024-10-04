import 'package:crewup_flutter/models/auth/login_request_dto.dart';
import 'package:crewup_flutter/screens/auth/signup_page.dart';
import 'package:crewup_flutter/service/auth/auth_service.dart';
import 'package:crewup_flutter/service/logger_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      String email = _emailController.text;
      String password = _passwordController.text;
      LoginRequestDto loginRequestDto =
          LoginRequestDto(email: email, password: password);

      _authService.login(loginRequestDto);
    }
  }

  void _signUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpPage()));
  }

  void _socialLogin(String platform) {
    logger.d('$platform 로그인 시도'); // Debug 레벨로 로그 출력
    // 소셜 로그인 로직 처리
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16.0),
                const Text(
                  '로그인',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),

                // 이메일 입력 필드
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: '이메일',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일을 입력하세요';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // 비밀번호 입력 필드
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력하세요';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // 로그인 버튼
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('로그인'),
                ),
                const SizedBox(height: 16.0),

                // 회원가입 버튼
                OutlinedButton(
                  onPressed: _signUp,
                  child: const Text('회원가입'),
                ),
                const SizedBox(height: 24.0),

                // 소셜 로그인 구분선
                const Row(
                  children: <Widget>[
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('소셜 로그인'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16.0),

                // 소셜 로그인 버튼들
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.account_circle,
                          size: 48), // 임시 아이콘 사용
                      onPressed: () => _socialLogin('Google'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.facebook, size: 48), // 임시 아이콘 사용
                      onPressed: () => _socialLogin('Facebook'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.apple, size: 48), // 임시 아이콘 사용
                      onPressed: () => _socialLogin('Apple'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
