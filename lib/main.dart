import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/services.dart';
import 'core/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        // 1. Primeiro cria o serviço base
        ChangeNotifierProvider(create: (_) => AuthService()),

        // 2. Usa ProxyProvider para injetar o AuthService nos outros Services
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

