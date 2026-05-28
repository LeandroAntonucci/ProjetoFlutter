import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../core/services/auth_service.dart';
import './app_routes.dart';
import '../../presentation/screens/screens.dart';
import '../data/models/task_draft.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        final route = settings.name;

        switch (route) {

          case AppRoutes.welcome:
            return const WelcomeScreen();

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
            return const MainScreen(initialIndex: 1);

          case AppRoutes.tasks:
            return const MainScreen(initialIndex: 2);

          case AppRoutes.settings:
            return const MainScreen(initialIndex: 3);

          case AppRoutes.taskCreate:
            final args = settings.arguments;
            if (args is! TaskCreationArgs) {
              return const Scaffold(
                body: Center(child: Text('Categoria da task não informada')),
              );
            }
            return TaskCreateScreen(category: args.category);

          case AppRoutes.taskSuccess:
            return const TaskSuccessScreen();

          default:
            return const Scaffold(
              body: Center(child: Text("Rota não encontrada")),
            );
        }
      },
    );
  }
}
