import 'package:flutter/material.dart';
import '../presentation/screens/screens.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String auth = '/auth';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  static const String onboarding = '/onboarding';


  static const main = '/main';

  // TASKS
  static const tasks = '/tasks';
  static const taskType = '/tasks/type';
  static const taskCreate = '/tasks/create';
  static const taskSuccess = '/tasks/success';

  static Map<String, WidgetBuilder> routes = {
    welcome: (_) => const WelcomeScreen(),
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    forgotPassword: (_) => const ForgotPasswordScreen(),
    resetPassword: (_) => const ResetPasswordScreen(),
    onboarding: (_) => const OnboardingScreen(),
  };
}
