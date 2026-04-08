import 'package:flutter/material.dart';
import '../core/services/auth_service.dart';
import 'app_routes.dart';

// screens
import '../../presentation/screens/screens.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // 🔥 sempre checa sessão
    AuthService.checkSession();

    final isLogged = AuthService.isLoggedIn;
    final seenOnboarding = AuthService.hasSeenOnboarding;

    // =========================
    // 🚀 DECISÃO GLOBAL (ENTRY POINT)
    // =========================
    if (settings.name == AppRoutes.welcome) {
      if (isLogged) {
        return _go(const MainScreen());
      }

      if (!seenOnboarding) {
        return _go(const OnboardingScreen());
      }

      return _go(const WelcomeScreen());
    }

    // =========================
    // 🔐 ROTAS PROTEGIDAS
    // =========================
    if (_isProtected(settings.name)) {
      if (!isLogged) {
        return _go(const LoginScreen());
      }
    }

    // =========================
    // 🔓 ROTAS DE AUTH
    // =========================
    if (_isAuthRoute(settings.name)) {
      if (isLogged) {
        return _go(const MainScreen());
      }
    }

    // =========================
    // 📍 ROTAS NORMAIS
    // =========================
    switch (settings.name) {
      case AppRoutes.login:
        return _go(const LoginScreen());

      case AppRoutes.register:
        return _go(const RegisterScreen());

      case AppRoutes.forgotPassword:
        return _go(const ForgotPasswordScreen());

      case AppRoutes.onboarding:
        return _go(const OnboardingScreen());

      case AppRoutes.main:
        return _go(const MainScreen());

      case AppRoutes.tasks:
        return _go(const TaskScreen());

      default:
        return _go(const Scaffold(
          body: Center(child: Text("Rota não encontrada")),
        ));
    }
  }

  // =========================
  // HELPERS
  // =========================
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
    ].contains(route);
  }

  static MaterialPageRoute _go(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}