import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/task_draft.dart';
import '../../../../data/models/task_draft_validator.dart';

class TaskFormBase extends StatefulWidget {
  final TaskCategory category;
  final String title;
  final String titleLabel;
  final ValueChanged<TaskDraft> onSubmit;

  const TaskFormBase({
    super.key,
    required this.category,
    required this.title,
    required this.titleLabel,
    required this.onSubmit,
  });

  @override
  State<TaskFormBase> createState() => _TaskFormBaseState();
}

class _TaskFormBaseState extends State<TaskFormBase> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _intervalController = TextEditingController();

  FrequencyType _frequencyType = FrequencyType.daily;
  IntervalUnit? _intervalUnit;

  @override
  void dispose() {
    _titleController.dispose();
    _intervalController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final intervalValue = int.tryParse(_intervalController.text.trim());

    final draft = TaskDraft(
      title: _titleController.text.trim(),
      category: widget.category,
      frequencyType: _frequencyType,
      intervalValue: _frequencyType == FrequencyType.custom ? intervalValue : null,
      intervalUnit: _frequencyType == FrequencyType.custom ? _intervalUnit : null,
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
          Text(
            widget.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: widget.titleLabel,
              border: const OutlineInputBorder(),
            ),
            validator: TaskDraftValidator.validateTitle,
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
                _frequencyType = value ?? FrequencyType.daily;
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