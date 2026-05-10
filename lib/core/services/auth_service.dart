import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/auth_provider.dart';
import '../providers/auth_response.dart';

class AuthService extends ChangeNotifier {
  AuthService(this._authProvider);

  final AuthData _authProvider;

  AuthResponseDto? _session;
  bool _isInitialized = false;

  AuthResponseDto? get session => _session;
  bool get isLoggedIn => _session != null;
  bool get isInitialized => _isInitialized;

  String get token => _session?.accessToken ?? '';
  String get userName => _session?.name ?? '';
  String get userEmail => _session?.email ?? '';

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('auth_session');

    if (raw != null) {
      try {
        final data = jsonDecode(raw) as Map<String, dynamic>;
        _session = AuthResponseDto(
          accessToken: data['accessToken'] ?? '',
          refreshToken: data['refreshToken'] ?? '',
          expiresIn: data['expiresIn'] ?? 0,
          userId: data['userId'] ?? '',
          name: data['name'] ?? 'Usuário',
          email: data['email'] ?? '',
        );
      } catch (_) {
        _session = null;
      }
    }

    _isInitialized = true;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      final username = _loginFromEmail(email);
      final response = await _authProvider.login(
        username: username,
        password: password,
      );

      _session = response;
      await _saveSession(response);
      notifyListeners();
    } catch (e) {
      throw Exception('Falha no login: $e');
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _authProvider.register(
        email: email,
        password: password,
      );

      await login(email, password);
    } catch (e) {
      throw Exception('Falha no cadastro: $e');
    }
  }

  Future<void> logout() async {
    _session = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_session');
    notifyListeners();
  }

  String _loginFromEmail(String email) {
    final trimmed = email.trim();
    final index = trimmed.indexOf('@');
    if (index > 0) return trimmed.substring(0, index);
    return trimmed;
  }

  Future<void> _saveSession(AuthResponseDto session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_session', jsonEncode(session.toJson()));
  }
}