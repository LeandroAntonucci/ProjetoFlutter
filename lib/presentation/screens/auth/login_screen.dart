import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../routes/app_routes.dart';
import '../../../core/services/login_service.dart';
import '../../widgets/auth_form_section_widget.dart';
import '../../widgets/auth_screen_shell_widget.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginService = context.watch<LoginService>();

    return AuthScreenShell(
      child: Column(
        children: [
          AuthFormSection(
            formKey: loginService.formKey,
            emailController: loginService.emailController,
            passwordController: loginService.passwordController,
            loading: loginService.loading,
            errorMessage: loginService.errorMessage,
            obscurePassword: loginService.obscurePassword,
            onTogglePasswordVisibility: loginService.togglePasswordVisibility,
            onSubmit: () async {
              await loginService.submitLogin();

              if (context.mounted && loginService.errorMessage == null) {
                Navigator.pushReplacementNamed(context, AppRoutes.main);
              }
            },
            emailValidator: loginService.validateEmail,
            passwordValidator: loginService.validatePassword,
            primaryButtonText: 'Entrar',
            bottomTextPrefix: 'Não tem uma conta ainda? ',
            bottomActionText: 'Se inscreva',
            onBottomTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.register);
            },
            title: 'Realize o Login',
          ),

          // 🔹 Esqueceu a senha
          Padding(
            padding: const EdgeInsets.only(right: 24, top: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.forgotPassword);
                },
                child: Text(
                  'Esqueceu a senha?',
                  style: AppTextStyles.helper.copyWith(
                    color: AppColors.main,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
