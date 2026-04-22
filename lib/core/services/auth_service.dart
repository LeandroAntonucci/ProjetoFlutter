import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  StreamSubscription<User?>? _authSub;

  bool _seenOnboarding = false;
  bool _isInitialized = false;

  // =========================
  // GETTERS
  // =========================
  User? get user => _auth.currentUser;

  bool get isLoggedIn => user != null;

  bool get hasSeenOnboarding => _seenOnboarding;

  bool get isInitialized => _isInitialized;

  // =========================
  // INIT (ESSENCIAL)
  // =========================
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    _seenOnboarding = prefs.getBool('onboarding') ?? false;

    // 🔥 escuta mudanças do Firebase (login/logout)
    _authSub = _auth.authStateChanges().listen((user) {
      notifyListeners();
    });

    _isInitialized = true;
    notifyListeners();
  }

  // =========================
  // LOGIN EMAIL/SENHA
  // =========================
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  // =========================
  // REGISTER
  // =========================
  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  // =========================
  // LOGOUT
  // =========================
  Future<void> logout() async {
    await _auth.signOut();
  }

  // =========================
  // RESET PASSWORD
  // =========================
  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  // =========================
  // ONBOARDING
  // =========================
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();

    _seenOnboarding = true;
    await prefs.setBool('onboarding', true);

    notifyListeners();
  }


  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Usuário não encontrado';
      case 'wrong-password':
        return 'Senha incorreta';
      case 'email-already-in-use':
        return 'Email já está em uso';
      case 'invalid-email':
        return 'Email inválido';
      case 'weak-password':
        return 'Senha muito fraca';
      case 'network-request-failed':
        return 'Sem conexão com a internet';
      default:
        return 'Erro inesperado (${e.code})';
    }
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
}