import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/task_draft.dart';
import '../../../../data/models/task_draft_validator.dart';

class WaterTaskForm extends StatefulWidget {
  final TaskCategory category;
  final ValueChanged<TaskDraft> onSubmit;

  const WaterTaskForm({
    super.key,
    required this.category,
    required this.onSubmit,
  });

  @override
  State<WaterTaskForm> createState() => _WaterTaskFormState();
}

class _WaterTaskFormState extends State<WaterTaskForm> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _intervalController = TextEditingController();
  final _waterAmountController = TextEditingController();
  final _notesController = TextEditingController();

  FrequencyType _frequencyType = FrequencyType.once;
  IntervalUnit? _intervalUnit;

  @override
  void dispose() {
    _titleController.dispose();
    _intervalController.dispose();
    _waterAmountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final intervalValue = int.tryParse(_intervalController.text.trim());
    final waterAmountMl = int.tryParse(_waterAmountController.text.trim());

    final draft = TaskDraft(
      title: _titleController.text.trim(),
      category: widget.category,
      frequencyType: _frequencyType,
      intervalValue: _frequencyType == FrequencyType.custom ? intervalValue : null,
      intervalUnit: _frequencyType == FrequencyType.custom ? _intervalUnit : null,
      waterAmountMl: waterAmountMl,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
    );

    final errors = TaskDraftValidator.validateDraft(draft);
    if (errors.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errors.first)),
      );
      return;
    }

    widget.onSubmit(draft);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Nome da hidratação',
              border: OutlineInputBorder(),
            ),
            validator: TaskDraftValidator.validateTitle,
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _waterAmountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Quantidade em ml',
              border: OutlineInputBorder(),
            ),
            validator: (value) => TaskDraftValidator.validateRequiredInt(
              value,
              fieldName: 'a quantidade em ml',
              min: 1,
              max: 10000,
            ),
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<FrequencyType>(
            value: _frequencyType,
            decoration: const InputDecoration(
              labelText: 'Frequência',
              border: OutlineInputBorder(),
            ),
            items: FrequencyType.values
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(item.label),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _frequencyType = value ?? FrequencyType.once;
                if (_frequencyType != FrequencyType.custom) {
                  _intervalController.clear();
                  _intervalUnit = null;
                }
              });
            },
            validator: TaskDraftValidator.validateFrequencyType,
          ),

          if (_frequencyType == FrequencyType.custom) ...[
            const SizedBox(height: 16),
            TextFormField(
              controller: _intervalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Intervalo',
                border: OutlineInputBorder(),
              ),
              validator: TaskDraftValidator.validateIntervalValue,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<IntervalUnit>(
              value: _intervalUnit,
              decoration: const InputDecoration(
                labelText: 'Unidade do intervalo',
                border: OutlineInputBorder(),
              ),
              items: IntervalUnit.values
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item.label),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _intervalUnit = value;
                });
              },
              validator: TaskDraftValidator.validateIntervalUnit,
            ),
          ],

          const SizedBox(height: 16),

          TextFormField(
            controller: _notesController,
            decoration: const InputDecoration(
              labelText: 'Observações',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.main,
                foregroundColor: AppColors.textOnMain,
              ),
              onPressed: _submit,
              child: const Text('Avançar'),
            ),
          ),
        ],
      ),
    );
  }
}