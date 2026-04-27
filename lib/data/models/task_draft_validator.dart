import 'task_draft.dart';

class TaskDraftValidator {
  static String? validateTitle(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Informe um título.';
    }

    if (text.length < 3) {
      return 'O título deve ter pelo menos 3 caracteres.';
    }

    if (text.length > 60) {
      return 'O título deve ter no máximo 60 caracteres.';
    }

    return null;
  }

  static String? validateRequiredInt(
    String? value, {
    required String fieldName,
    int min = 1,
    int max = 999999,
  }) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Informe $fieldName.';
    }

    final parsed = int.tryParse(text);
    if (parsed == null) {
      return 'Digite um número válido.';
    }

    if (parsed < min) {
      return '$fieldName deve ser maior ou igual a $min.';
    }

    if (parsed > max) {
      return '$fieldName deve ser menor ou igual a $max.';
    }

    return null;
  }

  static String? validateFrequencyType(FrequencyType? value) {
    if (value == null) {
      return 'Selecione a frequência.';
    }
    return null;
  }

  static String? validateIntervalValue(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Informe o intervalo.';
    }

    final parsed = int.tryParse(text);
    if (parsed == null) {
      return 'Digite um número válido.';
    }

    if (parsed <= 0) {
      return 'O intervalo deve ser maior que zero.';
    }

    if (parsed > 365) {
      return 'O intervalo está muito alto.';
    }

    return null;
  }

  static String? validateIntervalUnit(IntervalUnit? value) {
    if (value == null) {
      return 'Selecione a unidade do intervalo.';
    }
    return null;
  }

  static String? validateMealType(MealType? value) {
  if (value == null) {
    return 'Selecione o tipo de refeição.';
  }
  return null;
  }

  static List<String> validateDraft(TaskDraft draft) {
    final errors = <String>[];

    final titleError = validateTitle(draft.title);
    if (titleError != null) errors.add(titleError);

    final freqError = validateFrequencyType(draft.frequencyType);
    if (freqError != null) errors.add(freqError);

    final needsInterval = draft.frequencyType == FrequencyType.custom;

    if (needsInterval) {
      if (draft.intervalValue == null || draft.intervalValue! <= 0) {
        errors.add('Informe um intervalo válido.');
      }
      if (draft.intervalUnit == null) {
        errors.add('Selecione a unidade do intervalo.');
      }
    }

    switch (draft.category) {
      case TaskCategory.exercise:
        if (draft.durationMinutes == null || draft.durationMinutes! <= 0) {
          errors.add('Informe a duração do exercício.');
        }
        if (draft.intensity == null) {
          errors.add('Selecione a intensidade do exercício.');
        }
        break;

      case TaskCategory.meal:
        if (draft.mealType == null) {
          errors.add('Selecione o tipo de refeição.');
        }
        break;

      case TaskCategory.water:
        if (draft.waterAmountMl == null || draft.waterAmountMl! <= 0) {
          errors.add('Informe a quantidade de água.');
        }
        break;

      case TaskCategory.medication:
      case TaskCategory.other:
        break;
    }

    return errors;
  }
}