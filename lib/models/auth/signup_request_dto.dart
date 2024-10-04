class SignupRequestDto {
  final String email;
  final String name;
  final String nickname;
  final String password;

  SignupRequestDto({
    required this.email,
    required this.name,
    required this.nickname,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'nickname': nickname,
      'password': password,
    };
  }
}
