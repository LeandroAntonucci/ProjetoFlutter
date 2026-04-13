import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/auth_service.dart';
import 'app_routes.dart';

// screens
import '../../presentation/screens/screens.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        final auth = context.watch<AuthService>();

        final isLogged = auth.isLoggedIn;
        final seenOnboarding = auth.hasSeenOnboarding;

        final route = settings.name;

        // =========================
        // 🚀 ENTRY POINT (/)
        // =========================
        if (route == AppRoutes.welcome) {
          
          if (!isLogged) {
            return const WelcomeScreen();
          }

          return const MainScreen();
        }

        // =========================
        // 🔐 PROTEÇÃO
        // =========================
        if (_isProtected(route) && !isLogged) {
          return const LoginScreen();
        }

        // =========================
        // 🔓 BLOQUEAR AUTH SE LOGADO
        // =========================
        if (_isAuthRoute(route) && isLogged) {
          return const MainScreen();
        }

        // =========================
        // 📍 ROTAS
        // =========================
        switch (route) {
          case AppRoutes.login:
            return const LoginScreen();

          case AppRoutes.register:
            return const RegisterScreen();

          case AppRoutes.forgotPassword:
            return const ForgotPasswordScreen();

          case AppRoutes.passwordResetedOk:
            return const PasswordChangedScreen();

          case AppRoutes.onboarding:
            return const OnboardingScreen();

          case AppRoutes.main:
            return const MainScreen();

          case AppRoutes.tasks:
            return const TaskScreen();

          default:
            return const Scaffold(
              body: Center(child: Text("Rota não encontrada")),
            );
        }
      },
    );
  }

  static bool _isProtected(String? route) {
    return [
      AppRoutes.main,
      AppRoutes.tasks,
    ].contains(route);
  }

  static bool _isAuthRoute(String? route) {
    return [
      AppRoutes.login,
      AppRoutes.register,
      AppRoutes.forgotPassword,
    ].contains(route);
  }
}