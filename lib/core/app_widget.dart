import 'package:flutter/material.dart';
import 'package:lavie/routes/app_routes.dart';
import '../routes/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lavie',
      initialRoute: AppRoutes.resetPassword,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
