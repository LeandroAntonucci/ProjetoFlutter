enum TaskCategory {
  water,
  medication,
  exercise,
  meal,
  other,
}

enum TaskStatus {
  pending,
  done,
  missed,
  paused,
}

enum FrequencyType {
  daily,
  weekly,
  monthly,
  custom,
}

enum IntervalUnit {
  day,
  week,
  month,
}

class TaskCreationArgs {
  final TaskCategory category;

  const TaskCreationArgs({required this.category});
}
extension TaskCategoryApiX on TaskCategory {
  static TaskCategory fromApi(String value) {
    return switch (value.toUpperCase()) {
      'WATER' => TaskCategory.water,
      'MEDICATION' => TaskCategory.medication,
      'EXERCISE' => TaskCategory.exercise,
      'MEAL' => TaskCategory.meal,
      _ => TaskCategory.other,
    };
  }
}

extension TaskStatusApiX on TaskStatus {
  static TaskStatus fromApi(String value) {
    return switch (value.toUpperCase()) {
      'DONE' => TaskStatus.done,
      'MISSED' => TaskStatus.missed,
      'PAUSED' => TaskStatus.paused,
      _ => TaskStatus.pending,
    };
  }
}

extension TaskCategoryX on TaskCategory {
  String get apiValue => switch (this) {
        TaskCategory.water => 'WATER',
        TaskCategory.medication => 'MEDICATION',
        TaskCategory.exercise => 'EXERCISE',
        TaskCategory.meal => 'MEAL',
        TaskCategory.other => 'OTHER',
      };

  String get label => switch (this) {
        TaskCategory.water => 'Hidratação',
        TaskCategory.medication => 'Medicação',
        TaskCategory.exercise => 'Exercício',
        TaskCategory.meal => 'Refeição',
        TaskCategory.other => 'Outra',
      };
}

extension FrequencyTypeX on FrequencyType {
  String get apiValue => switch (this) {
        FrequencyType.daily => 'DAILY',
        FrequencyType.weekly => 'WEEKLY',
        FrequencyType.monthly => 'MONTHLY',
        FrequencyType.custom => 'CUSTOM',
      };

  String get label => switch (this) {
        FrequencyType.daily => 'Diária',
        FrequencyType.weekly => 'Semanal',
        FrequencyType.monthly => 'Mensal',
        FrequencyType.custom => 'Personalizada',
      };
}

extension IntervalUnitX on IntervalUnit {
  String get apiValue => switch (this) {
        IntervalUnit.day => 'DAY',
        IntervalUnit.week => 'WEEK',
        IntervalUnit.month => 'MONTH',
      };

  String get label => switch (this) {
        IntervalUnit.day => 'Dias',
        IntervalUnit.week => 'Semanas',
        IntervalUnit.month => 'Meses',
      };
}

class TaskDraft {
  final String title;
  final TaskCategory category;
  final FrequencyType frequencyType;
  final int? intervalValue;
  final IntervalUnit? intervalUnit;

  const TaskDraft({
    required this.title,
    required this.category,
    required this.frequencyType,
    this.intervalValue,
    this.intervalUnit,
  });

  factory TaskDraft.empty(TaskCategory category) {
    return TaskDraft(
      title: '',
      category: category,
      frequencyType: FrequencyType.daily,
    );
  }

  Map<String, dynamic> toCreateBody({required int authorId}) {
    return {
      'title': title.trim(),
      'category': category.apiValue,
      'status': TaskStatus.pending.name.toUpperCase(),
      'frequencyType': frequencyType.apiValue,
      'intervalValue': intervalValue,
      'intervalUnit': intervalUnit?.apiValue,
      'completionDate': null,
      'authorId': authorId,
    };
  }
}
