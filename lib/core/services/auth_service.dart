import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _seenOnboarding = false;

  // =========================
  // GETTERS
  // =========================
  User? get user => _auth.currentUser;
  bool get isLoggedIn => user != null;
  bool get hasSeenOnboarding => _seenOnboarding;

  // =========================
  // INIT
  // =========================
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _seenOnboarding = prefs.getBool('onboarding') ?? false;

    // 🔥 escuta mudanças do Firebase
    _auth.authStateChanges().listen((_) {
      notifyListeners();
    });

    notifyListeners();
  }

  // =========================
  // LOGIN EMAIL/SENHA
  // =========================
  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // =========================
  // REGISTER
  // =========================
  Future<void> register(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
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
    await _auth.sendPasswordResetEmail(email: email);
  }

  // =========================
  // ONBOARDING
  // =========================
  Future<void> completeOnboarding() async {
    _seenOnboarding = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding', true);

    notifyListeners();
  }
}