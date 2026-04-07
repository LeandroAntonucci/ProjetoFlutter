import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../observers/route_observer.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Brasil Navigator',
      initialRoute: AppRoutes.welcome,
      routes: AppRoutes.routes,
      navigatorObservers: [AppRouteObserver.instance],
    );
  }
}