import 'package:flutter/material.dart';

import '../../../../data/models/task_draft.dart';
import 'task_form_base.dart';

class WaterTaskForm extends StatelessWidget {
  final TaskCategory category;
  final ValueChanged<TaskDraft> onSubmit;

  const WaterTaskForm({
    super.key,
    required this.category,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TaskFormBase(
      category: category,
      title: 'Nova tarefa de hidratação',
      titleLabel: 'Nome da hidratação',
      onSubmit: onSubmit,
    );
  }
}