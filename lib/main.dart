import 'package:crewup_flutter/screens/auth/login_page.dart';
import 'package:crewup_flutter/screens/home/home_page.dart';
import 'package:crewup_flutter/service/auth/%08jwt_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final JwtService _jwtService = JwtService();
  bool _isCheckingToken = true;
  bool _hasToken = false;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    String? accessToken = await _jwtService.getAccessToken();

    setState(() {
      _hasToken = accessToken != null;
      _isCheckingToken = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _isCheckingToken
          ? const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            )
          : _hasToken
              ? HomePage()
              : const LoginPage(),
    );
  }
}
