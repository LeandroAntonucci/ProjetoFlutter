import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/auth_service.dart';
import 'app_routes.dart';
import '../../presentation/screens/screens.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        final auth = context.watch<AuthService>();
        final route = settings.name;

        final isLogged = auth.isLoggedIn;
        final seenOnboarding = auth.hasSeenOnboarding;

        // if (route == AppRoutes.welcome) {
        //   if (!seenOnboarding) {
        //     return const OnboardingScreen();
        //   }

        //   if (!isLogged) {
        //     return const WelcomeScreen();
        //   }

        //   return const MainScreen();
        // }

        // if (_isProtected(route) && !isLogged) {
        //   return const LoginScreen();
        // }

        // if (_isAuthRoute(route) && isLogged) {
        //   return const MainScreen();
        // }

        switch (route) {
          case AppRoutes.login:
            return const LoginScreen();

          case AppRoutes.register:
            return const RegisterScreen();

          case AppRoutes.forgotPassword:
            return const ForgotPasswordScreen();

          case AppRoutes.resetPassword:
            return const ResetPasswordScreen();

          case AppRoutes.passwordResetedOk:
            return const PasswordChangedScreen();

          case AppRoutes.onboarding:
            return const OnboardingScreen();

          case AppRoutes.main:
            return const MainScreen(initialIndex: 0);

          case AppRoutes.chat:
            return const MainScreen(initialIndex: 2);

          case AppRoutes.tasks:
            return const MainScreen(initialIndex: 1);

          case AppRoutes.settings:
            return const MainScreen(initialIndex: 3);

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
      AppRoutes.chat,
      AppRoutes.tasks,
      AppRoutes.settings,
    ].contains(route);
  }

  static bool _isAuthRoute(String? route) {
    return [
      AppRoutes.login,
      AppRoutes.register,
      AppRoutes.forgotPassword,
      AppRoutes.resetPassword,
    ].contains(route);
  }
}
