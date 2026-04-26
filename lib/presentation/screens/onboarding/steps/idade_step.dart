import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../widgets/horizontal_picker_widget.dart';
import '../../../widgets/primary_button_widget.dart';

class IdadeStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final Function(int) onChanged;

  const IdadeStep({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.onChanged,
  });

  @override
  State<IdadeStep> createState() => _IdadeStepState();
}

class _IdadeStepState extends State<IdadeStep> {
  int idade = 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: widget.onBack,
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.main,
                            size: 20,
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 44),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Text(
                      "Qual sua idade?",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.h2.copyWith(
                        color: const Color(0xFF2E214D),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.main,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: HorizontalPicker(
                        min: 0,
                        max: 200,
                        initialValue: idade,
                        onChanged: (value) {
                          setState(() {
                            idade = value;
                          });

                          widget.onChanged(value);
                        },
                      ),
                    ),

                    const Spacer(),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: PrimaryButton(
                        text: "Avançar >>>",
                        onPressed: widget.onNext,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}