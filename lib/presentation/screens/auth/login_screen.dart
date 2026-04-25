import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../routes/app_routes.dart';
import '../../../core/services/login_service.dart';
import '../../widgets/auth_form_section.dart';
import '../../widgets/auth_screen_shell.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginService = context.watch<LoginService>();

    return AuthScreenShell(
      child: AuthFormSection(
        formKey: loginService.formKey,
        emailController: loginService.emailController,
        passwordController: loginService.passwordController,
        loading: loginService.loading,
        errorMessage: loginService.errorMessage,
        obscurePassword: loginService.obscurePassword,
        onTogglePasswordVisibility: loginService.togglePasswordVisibility,
        onSubmit: loginService.submitLogin,
        emailValidator: loginService.validateEmail,
        passwordValidator: loginService.validatePassword,
        primaryButtonText: 'Entrar',
        bottomTextPrefix: 'Não tem uma conta ainda? ',
        bottomActionText: 'Se inscreva',
        onBottomTap: () {
          Navigator.pushReplacementNamed(context, AppRoutes.main);
        },
        title: 'Realize o Login',
      ),
    );
  }
}