import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../observers/route_observer.dart';
import './constants/constants.dart';
import '../routes/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lavie',
      initialRoute: AppRoutes.welcome,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorObservers: [AppRouteObserver.instance],
    );
  }
}