import 'package:flutter/material.dart';

import '../../../../data/models/task_draft.dart';
import 'task_form_base.dart';

class MealTaskForm extends StatelessWidget {
  final TaskCategory category;
  final ValueChanged<TaskDraft> onSubmit;

  const MealTaskForm({
    super.key,
    required this.category,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TaskFormBase(
      category: category,
      title: 'Nova tarefa de refeição',
      titleLabel: 'Nome da refeição',
      onSubmit: onSubmit,
    );
  }
}