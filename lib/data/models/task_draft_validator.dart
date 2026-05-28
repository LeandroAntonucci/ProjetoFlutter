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

    return null;
  }

  static String? validateIntervalUnit(IntervalUnit? value) {
    if (value == null) {
      return 'Selecione a unidade do intervalo.';
    }
    return null;
  }

  static List<String> validateDraft(TaskDraft draft) {
    final errors = <String>[];

    final titleError = validateTitle(draft.title);
    if (titleError != null) errors.add(titleError);

    final freqError = validateFrequencyType(draft.frequencyType);
    if (freqError != null) errors.add(freqError);

    if (draft.frequencyType == FrequencyType.custom) {
      if (draft.intervalValue == null || draft.intervalValue! <= 0) {
        errors.add('Informe um intervalo válido.');
      }
      if (draft.intervalUnit == null) {
        errors.add('Selecione a unidade do intervalo.');
      }
    }

    return errors;
  }
}