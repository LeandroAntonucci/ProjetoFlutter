import 'package:flutter/material.dart';
import '../../../core/services/auth_service.dart';

class RegisterService extends ChangeNotifier {
  RegisterService(this._authService);

  final AuthService _authService;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;
  bool obscurePassword = true;
  String? errorMessage;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  String? validateUserName(String? value) {
    final userName = value?.trim() ?? '';
    if (userName.isEmpty) return 'Informe seu nome de usuário.';
    return null;
  }

  String? validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Informe sua senha.';
    if (password.length < 6) return 'A senha deve ter ao menos 6 caracteres.';
    return null;
  }

  Future<bool> submitRegister() async {
    if (!formKey.currentState!.validate()) return false;

    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _authService.register(
        userNameController.text.trim(),
        passwordController.text.trim(),
      );
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
