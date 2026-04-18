import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class NomeStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final Function(String) onChanged;

  const NomeStep({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.onChanged,
  });

  @override
  State<NomeStep> createState() => _NomeStepState();
}

class _NomeStepState extends State<NomeStep> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final maxWidth = isMobile ? constraints.maxWidth : 520.0;
        final horizontalPadding = isMobile ? 20.0 : 28.0;

        return Container(
          color: Colors.black,
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                  vertical: 8,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Container(
                    width: maxWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: 14,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _BackButton(onTap: widget.onBack),
                                const Spacer(),
                                const Expanded(
                                  child: _StepProgressBar(
                                    currentIndex: 1,
                                    totalSteps: 3,
                                  ),
                                ),
                                const Spacer(),
                                const SizedBox(width: 44),
                              ],
                            ),
                            const SizedBox(height: 26),
                            Center(
                              child: Text(
                                'What is your\nname?',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.h1.copyWith(
                                  color: const Color(0xFF2E214D),
                                  fontSize: (constraints.maxWidth * 0.075)
                                      .clamp(26.0, 34.0),
                                  height: 1.05,
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            Text(
                              'Nome',
                              style: AppTextStyles.helper.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextField(
                              controller: _controller,
                              onChanged: widget.onChanged,
                              style: AppTextStyles.inputText.copyWith(
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                hintText: 'I enter your Name',
                                hintStyle: AppTextStyles.inputPlaceholder.copyWith(
                                  color: Colors.grey.shade500,
                                ),
                                prefixIcon: const Icon(
                                  Icons.person_outline,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                suffixIcon: const Icon(
                                  Icons.visibility_off_outlined,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                filled: false,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 14,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.main,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                height: 52,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.main,
                                    foregroundColor: AppColors.textOnMain,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      side: const BorderSide(
                                        color: AppColors.border,
                                        width: 1,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 12,
                                    ),
                                  ),
                                  onPressed: () {
                                    widget.onNext();
                                  },
                                  child: Text(
                                    'Avançar  >>>',
                                    style: AppTextStyles.button.copyWith(
                                      color: AppColors.textOnMain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
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

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16,
            color: AppColors.main,
          ),
        ),
      ),
    );
  }
}

class _StepProgressBar extends StatelessWidget {
  final int currentIndex;
  final int totalSteps;

  const _StepProgressBar({
    required this.currentIndex,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isActive = index == currentIndex;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: index == totalSteps - 1 ? 0 : 6,
            ),
            height: 4,
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.black87
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      }),
    );
  }
}