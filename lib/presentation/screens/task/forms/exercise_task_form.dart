import 'package:flutter/material.dart';

import '../../../../data/models/task_draft.dart';
import 'task_form_base.dart';

class ExerciseTaskForm extends StatelessWidget {
  final TaskCategory category;
  final ValueChanged<TaskDraft> onSubmit;

  const ExerciseTaskForm({
    super.key,
    required this.category,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TaskFormBase(
      category: category,
      title: 'Nova tarefa de exercício',
      titleLabel: 'Nome do exercício',
      onSubmit: onSubmit,
    );
  }
}