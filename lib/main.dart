import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_widget.dart';
import 'core/network/api_client.dart';
import 'core/services/services.dart';
import 'data/datasources/task_remote_datasource.dart';
import 'data/repositories/tasks_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authService = AuthService(AuthProvider());
  await authService.init();

  runApp(
    MultiProvider(
      providers: [
        Provider<ApiClient>(
          create: (_) => ApiClient(),
        ),

        Provider<TasksRemoteDataSource>(
          create: (context) => TasksRemoteDataSource(
            apiClient: context.read<ApiClient>(),
          ),
        ),

        Provider<TasksRepository>(
          create: (context) => TasksRepository(
            context.read<TasksRemoteDataSource>(),
          ),
        ),

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
