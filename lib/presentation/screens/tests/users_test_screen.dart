import 'package:flutter/material.dart';

import '../../../core/network/api_client.dart';
import '../../../data/datasources/users_remote_datasource.dart';
import '../../../data/datasources/task_remote_datasource.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/task_model.dart';
import '../../../data/repositories/users_repository.dart';
import '../../../data/repositories/tasks_repository.dart';

class UsersTestScreen extends StatefulWidget {
  const UsersTestScreen({super.key});

  @override
  State<UsersTestScreen> createState() => _UsersTestScreenState();
}

class _UsersTestScreenState extends State<UsersTestScreen> {
  late Future<List<UserModel>> futureUsers;
  late Future<List<TaskModel>> futureTasks;

  @override
  void initState() {
    super.initState();

    final apiClient = ApiClient();

    final usersDatasource = UsersRemoteDatasource(apiClient: apiClient);
    final usersRepository = UsersRepository(usersDatasource);
    futureUsers = usersRepository.getUsers();

    final tasksDatasource = TasksRemoteDataSource(apiClient: apiClient);
    final tasksRepository = TasksRepository(tasksDatasource);
    futureTasks = tasksRepository.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste da API'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Usuários',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          FutureBuilder<List<UserModel>>(
            future: futureUsers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Text('Erro ao carregar usuários: ${snapshot.error}');
              }

              final users = snapshot.data ?? [];

              if (users.isEmpty) {
                return const Text('Nenhum usuário encontrado');
              }

              return Column(
                children: users.map((user) {
                  return Card(
                    child: ListTile(
                      title: Text(user.name ?? 'Sem nome'),
                      subtitle: Text(user.email),
                      trailing: Text(user.role),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Tasks',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          FutureBuilder<List<TaskModel>>(
            future: futureTasks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Text('Erro ao carregar tasks: ${snapshot.error}');
              }

              final tasks = snapshot.data ?? [];

              if (tasks.isEmpty) {
                return const Text('Nenhuma task encontrada');
              }

              return Column(
                children: tasks.map((task) {
                  return Card(
                    child: ListTile(
                      title: Text(task.title),
                      subtitle: Text(
                        '${task.category} • ${task.status} • ${task.frequencyType}',
                      ),
                      trailing: Text('#${task.id}'),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}