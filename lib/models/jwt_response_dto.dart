class JwtResponseDto {
  final String accessToken;
  final String refreshToken;

  JwtResponseDto({
    required this.accessToken,
    required this.refreshToken,
  });

  factory JwtResponseDto.fromJson(Map<String, dynamic> json) {
    return JwtResponseDto(
      accessToken: json['data']['accessToken'],
      refreshToken: json['data']['refreshToken'],
    );
  }
}
