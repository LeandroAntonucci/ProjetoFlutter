import 'package:flutter/material.dart';

import '../models/task_draft.dart';

class TaskCardStyleMapper {
  static Color accentColor(TaskCategory category) => switch (category) {
        TaskCategory.water => Colors.blue,
        TaskCategory.medication => Colors.purple,
        TaskCategory.exercise => Colors.green,
        TaskCategory.meal => Colors.orange,
        TaskCategory.other => Colors.grey,
      };

  static IconData icon(TaskCategory category) => switch (category) {
        TaskCategory.water => Icons.water_drop,
        TaskCategory.medication => Icons.medication,
        TaskCategory.exercise => Icons.fitness_center,
        TaskCategory.meal => Icons.restaurant,
        TaskCategory.other => Icons.task,
      };

  static String buttonText(TaskStatus status) => switch (status) {
        TaskStatus.done => 'Concluída',
        TaskStatus.missed => 'Revisar',
        TaskStatus.paused => 'Pausada',
        TaskStatus.pending => 'Concluir',
      };
}