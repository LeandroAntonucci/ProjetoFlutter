import '../datasources/task_remote_datasource.dart';
import '../models/task_draft.dart';
import '../models/task_model.dart';

class TasksRepository {
  final TasksRemoteDataSource datasource;

  TasksRepository(this.datasource);

  Future<List<TaskModel>> getTasks() {
    return datasource.getTasks();
  }

  Future<TaskModel> createTask({
    required TaskDraft draft,
    required int authorId,
  }) {
    return datasource.createTask(
      draft: draft,
      authorId: authorId,
    );
  }
}