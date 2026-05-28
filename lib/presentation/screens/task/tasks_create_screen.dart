import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/task_draft.dart';
import '../../../data/repositories/tasks_repository.dart';
import '../../../routes/app_routes.dart';
import 'forms/exercise_task_form.dart';
import 'forms/meal_task_form.dart';
import 'forms/water_task_form.dart';

class TaskCreateScreen extends StatelessWidget {
  final TaskCategory category;

  const TaskCreateScreen({super.key, required this.category});

  Future<bool> _confirmCancel(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Cancelar criação?'),
          content: const Text('Deseja cancelar a criação da task?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  Future<void> _goBackToTasks(BuildContext context) async {
    final shouldCancel = await _confirmCancel(context);
    if (!context.mounted) return;

    if (shouldCancel) {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.tasks, (route) => false);
    }
  }

  // int _getAuthorId(AuthService authService) {
  //   final authorId = authService.session?.localUserId;

  //   if (authorId == null) {
  //     throw StateError(
  //       'Sessão sem localUserId. O authorId precisa vir do usuário do Prisma.',
  //     );
  //   }

  //   return authorId;
  // }

  Future<void> _saveAndGoSuccess(BuildContext context, TaskDraft draft) async {
    final tasksRepository = context.read<TasksRepository>();
    // final authService = context.read<AuthService>();

    // final authorId = _getAuthorId(authService);
    final authorId = 1;

    await tasksRepository.createTask(draft: draft, authorId: authorId);

    if (!context.mounted) return;

    Navigator.of(context).pushNamed(AppRoutes.taskSuccess);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await _goBackToTasks(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nova ${category.label}'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _goBackToTasks(context),
          ),
        ),
        body: SafeArea(
          child: switch (category) {
            TaskCategory.exercise => ExerciseTaskForm(
              category: category,
              onSubmit: (draft) => _saveAndGoSuccess(context, draft),
            ),
            TaskCategory.meal => MealTaskForm(
              category: category,
              onSubmit: (draft) => _saveAndGoSuccess(context, draft),
            ),
            TaskCategory.water => WaterTaskForm(
              category: category,
              onSubmit: (draft) => _saveAndGoSuccess(context, draft),
            ),
            TaskCategory.medication => MealTaskForm(
              category: category,
              onSubmit: (draft) => _saveAndGoSuccess(context, draft),
            ),
            TaskCategory.other => MealTaskForm(
              category: category,
              onSubmit: (draft) => _saveAndGoSuccess(context, draft),
            ),
          },
        ),
      ),
    );
  }
}
