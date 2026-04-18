import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String? selectedOption;

  final List<_TaskOption> options = const [
    _TaskOption(title: 'Exercícios', value: 'exercicios'),
    _TaskOption(title: 'Refeição', value: 'refeicao'),
    _TaskOption(title: 'Hidratação', value: 'hidratacao'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.main,
      child: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 28,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 18),

                          Text(
                            'O que você deseja\nadicionar?',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.h2.copyWith(
                              color: const Color(0xFF312D49),
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            'Selecione o que deseja adicionar\n',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.helper.copyWith(
                              color: Colors.black45,
                            ),
                          ),

                          const SizedBox(height: 34),

                          ...options.map((option) {
                            final isEmpty = option.title.isEmpty;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _optionCard(
                                text: option.title,
                                selected: selectedOption == option.value,
                                disabled: isEmpty,
                                onTap: isEmpty
                                    ? null
                                    : () {
                                        setState(() {
                                          selectedOption = option.value;
                                        });
                                      },
                              ),
                            );
                          }),

                          const Spacer(),

                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.main,
                                foregroundColor: AppColors.textOnMain,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: selectedOption == null
                                  ? null
                                  : () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.taskType,
                                      );
                                    },
                              child: Text(
                                'Avançar  >>>',
                                style: AppTextStyles.button.copyWith(
                                  color: AppColors.textOnMain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _optionCard({
    required String text,
    required bool selected,
    required bool disabled,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: disabled
                ? const Color(0xFFE0E0E0)
                : selected
                ? const Color(0xFF312D49)
                : const Color(0xFFE0E0E0),
            width: 1.4,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyles.helper.copyWith(
            color: disabled ? Colors.transparent : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _TaskOption {
  final String title;
  final String value;

  const _TaskOption({required this.title, required this.value});
}
