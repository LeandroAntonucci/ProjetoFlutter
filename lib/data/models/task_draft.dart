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
  once,
  daily,
  weekly,
  custom,
}

enum IntervalUnit {
  minutes,
  hours,
  days,
  weeks,
}

enum ExerciseIntensity {
  low,
  medium,
  high,
}

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
  other,
}

class TaskCreationArgs {
  final TaskCategory category;

  const TaskCreationArgs({required this.category});
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
        FrequencyType.once => 'ONCE',
        FrequencyType.daily => 'DAILY',
        FrequencyType.weekly => 'WEEKLY',
        FrequencyType.custom => 'CUSTOM',
      };

  String get label => switch (this) {
        FrequencyType.once => 'Uma vez',
        FrequencyType.daily => 'Diária',
        FrequencyType.weekly => 'Semanal',
        FrequencyType.custom => 'Personalizada',
      };
}

extension IntervalUnitX on IntervalUnit {
  String get apiValue => switch (this) {
        IntervalUnit.minutes => 'MINUTES',
        IntervalUnit.hours => 'HOURS',
        IntervalUnit.days => 'DAYS',
        IntervalUnit.weeks => 'WEEKS',
      };

  String get label => switch (this) {
        IntervalUnit.minutes => 'Minutos',
        IntervalUnit.hours => 'Horas',
        IntervalUnit.days => 'Dias',
        IntervalUnit.weeks => 'Semanas',
      };
}

extension ExerciseIntensityX on ExerciseIntensity {
  String get label => switch (this) {
        ExerciseIntensity.low => 'Leve',
        ExerciseIntensity.medium => 'Moderada',
        ExerciseIntensity.high => 'Intensa',
      };
}

extension MealTypeX on MealType {
  String get label => switch (this) {
        MealType.breakfast => 'Café da manhã',
        MealType.lunch => 'Almoço',
        MealType.dinner => 'Jantar',
        MealType.snack => 'Lanche',
        MealType.other => 'Outro',
      };
}

class TaskDraft {
  final String title;
  final TaskCategory category;
  final FrequencyType frequencyType;
  final int? intervalValue;
  final IntervalUnit? intervalUnit;

  final int? durationMinutes;
  final ExerciseIntensity? intensity;

  final MealType? mealType;
  final int? waterAmountMl;

  final String? notes;

  const TaskDraft({
    required this.title,
    required this.category,
    required this.frequencyType,
    this.intervalValue,
    this.intervalUnit,
    this.durationMinutes,
    this.intensity,
    this.mealType,
    this.waterAmountMl,
    this.notes,
  });

  factory TaskDraft.empty(TaskCategory category) {
    return TaskDraft(
      title: '',
      category: category,
      frequencyType: FrequencyType.once,
    );
  }

  TaskDraft copyWith({
    String? title,
    TaskCategory? category,
    FrequencyType? frequencyType,
    int? intervalValue,
    IntervalUnit? intervalUnit,
    int? durationMinutes,
    ExerciseIntensity? intensity,
    MealType? mealType,
    int? waterAmountMl,
    String? notes,
    bool clearIntervalValue = false,
    bool clearIntervalUnit = false,
    bool clearDurationMinutes = false,
    bool clearIntensity = false,
    bool clearMealType = false,
    bool clearWaterAmountMl = false,
    bool clearNotes = false,
  }) {
    return TaskDraft(
      title: title ?? this.title,
      category: category ?? this.category,
      frequencyType: frequencyType ?? this.frequencyType,
      intervalValue: clearIntervalValue ? null : intervalValue ?? this.intervalValue,
      intervalUnit: clearIntervalUnit ? null : intervalUnit ?? this.intervalUnit,
      durationMinutes: clearDurationMinutes ? null : durationMinutes ?? this.durationMinutes,
      intensity: clearIntensity ? null : intensity ?? this.intensity,
      mealType: clearMealType ? null : mealType ?? this.mealType,
      waterAmountMl: clearWaterAmountMl ? null : waterAmountMl ?? this.waterAmountMl,
      notes: clearNotes ? null : notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson({required int authorId}) {
    return {
      'title': title.trim(),
      'category': category.apiValue,
      'status': TaskStatus.pending.name.toUpperCase(),
      'frequencyType': frequencyType.apiValue,
      'intervalValue': intervalValue,
      'intervalUnit': intervalUnit?.apiValue,
      'durationMinutes': durationMinutes,
      'intensity': intensity?.name.toUpperCase(),
      'mealType': mealType?.name.toUpperCase(),
      'waterAmountMl': waterAmountMl,
      'notes': notes,
      'authorId': authorId,
    };
  }
}