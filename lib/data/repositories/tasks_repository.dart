import '../datasources/task_remote_datasource.dart';
import '../models/task_model.dart';

class TasksRepository {
  final TasksRemoteDataSource datasource;

  TasksRepository(this.datasource);

  Future<List<TaskModel>> getTasks() {
    return datasource.getTasks();
  }
}