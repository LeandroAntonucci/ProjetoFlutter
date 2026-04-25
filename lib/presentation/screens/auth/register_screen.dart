import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../routes/app_routes.dart';
import '../../../core/services/register_service.dart';
import '../../widgets/auth_form_section.dart';
import '../../widgets/auth_screen_shell.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerService = context.watch<RegisterService>();

    return AuthScreenShell(
      child: AuthFormSection(
        formKey: registerService.formKey,
        emailController: registerService.emailController,
        passwordController: registerService.passwordController,
        loading: registerService.loading,
        errorMessage: registerService.errorMessage,
        obscurePassword: registerService.obscurePassword,
        onTogglePasswordVisibility: registerService.togglePasswordVisibility,
        onSubmit: () async {
          final success = await registerService.submitRegister();
          if (success && context.mounted) {
            Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
          }
        },
        emailValidator: registerService.validateEmail,
        passwordValidator: registerService.validatePassword,
        primaryButtonText: 'Cadastrar',
        bottomTextPrefix: 'Já tem uma conta? ',
        bottomActionText: 'Entrar',
        onBottomTap: () {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        },
        title: 'Criar conta',
      ),
    );
  }
}