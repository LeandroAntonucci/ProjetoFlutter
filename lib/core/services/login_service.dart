import 'package:flutter/material.dart';
import '../../../core/services/auth_service.dart';

class LoginService extends ChangeNotifier {
  LoginService(this._authService);

  final AuthService _authService;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;
  bool obscurePassword = true;
  String? errorMessage;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Informe seu email.';
    if (!email.contains('@') || !email.contains('.')) {
      return 'Informe um email válido.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Informe sua senha.';
    if (password.length < 6) return 'A senha deve ter ao menos 6 caracteres.';
    return null;
  }

  Future<void> submitLogin() async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}