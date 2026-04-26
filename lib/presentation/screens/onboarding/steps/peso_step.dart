import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../widgets/horizontal_picker_widget.dart';
import '../../../widgets/primary_button_widget.dart';

class PesoStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final Function(double) onChanged;

  const PesoStep({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.onChanged,
  });

  @override
  State<PesoStep> createState() => _PesoStepState();
}

class _PesoStepState extends State<PesoStep> {
  double peso = 70;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
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
                        // TOP
                        Row(
                          children: [
                            IconButton(
                              onPressed: widget.onBack,
                              icon: const Icon(Icons.arrow_back),
                            ),
                            const Spacer(),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Qual o seu peso?",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h2,
                        ),

                        const SizedBox(height: 20),

                        // CARD VERDE
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
                            initialValue: peso.toInt(),
                            onChanged: (value) {
                              setState(() {
                                peso = value.toDouble();
                              });

                              widget.onChanged(peso);
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
      },
    );
  }
}