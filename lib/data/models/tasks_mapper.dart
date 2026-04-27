import 'package:flutter/material.dart';

class TaskCardStyleMapper {
  static Color accentColor(String category) {
    switch (category) {
      case 'WATER':
        return Colors.blue;
      case 'MEDICATION':
        return Colors.purple;
      case 'EXERCISE':
        return Colors.green;
      case 'MEAL':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  static IconData icon(String category) {
    switch (category) {
      case 'WATER':
        return Icons.water_drop;
      case 'MEDICATION':
        return Icons.medication;
      case 'EXERCISE':
        return Icons.fitness_center;
      case 'MEAL':
        return Icons.restaurant;
      default:
        return Icons.task;
    }
  }

  static String buttonText(String status) {
    switch (status) {
      case 'DONE':
        return 'Concluída';
      case 'MISSED':
        return 'Revisar';
      case 'PAUSED':
        return 'Pausada';
      default:
        return 'Concluir';
    }
  }
}