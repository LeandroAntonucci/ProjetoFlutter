import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/services/services.dart';
import 'core/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authService = AuthService(AuthProvider());
  await authService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>.value(
          value: authService,
        ),

        ChangeNotifierProxyProvider<AuthService, LoginService>(
          create: (context) => LoginService(context.read<AuthService>()),
          update: (context, auth, previous) => previous ?? LoginService(auth),
        ),

        ChangeNotifierProxyProvider<AuthService, RegisterService>(
          create: (context) => RegisterService(context.read<AuthService>()),
          update: (context, auth, previous) => previous ?? RegisterService(auth),
        ),
      ],
      child: const MyApp(),
    ),
  );
}