import 'package:jwt_decoder/jwt_decoder.dart';

class AuthResponseDto {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final String userId;
  final String name;
  final String email;
  final int? localUserId;

  AuthResponseDto({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.userId,
    required this.name,
    required this.email,
    this.localUserId,
  });

  AuthResponseDto copyWith({
    String? accessToken,
    String? refreshToken,
    int? expiresIn,
    String? userId,
    String? name,
    String? email,
    int? localUserId,
  }) {
    return AuthResponseDto(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      localUserId: localUserId ?? this.localUserId,
    );
  }

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    final token = (json['accessToken'] ?? json['access_token'] ?? '') as String;
    final refreshToken =
        (json['refreshToken'] ?? json['refresh_token'] ?? '') as String;

    final expiresInRaw = json['expiresIn'] ?? json['expires_in'] ?? 0;
    final expiresIn = expiresInRaw is int
        ? expiresInRaw
        : int.tryParse(expiresInRaw.toString()) ?? 0;

    final payload =
        token.isNotEmpty ? JwtDecoder.decode(token) : <String, dynamic>{};

    return AuthResponseDto(
      accessToken: token,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
      userId: payload['sub']?.toString() ??
          json['userId']?.toString() ??
          '',
      name: payload['name']?.toString() ??
          json['name']?.toString() ??
          'Usuário',
      email: payload['email']?.toString() ??
          json['email']?.toString() ??
          '',
      localUserId: json['localUserId'] is int
          ? json['localUserId'] as int
          : int.tryParse(json['localUserId']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
      'userId': userId,
      'name': name,
      'email': email,
      'localUserId': localUserId,
    };
  }
}