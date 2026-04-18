import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class IntroStep extends StatelessWidget {
  final VoidCallback onNext;

  const IntroStep({
    super.key,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        final panelWidth = isMobile
            ? constraints.maxWidth
            : constraints.maxWidth.clamp(420.0, 520.0);

        final panelPadding = isMobile ? 18.0 : 24.0;
        final titleSize = (constraints.maxWidth * 0.085).clamp(28.0, 38.0);
        final bodySize = (constraints.maxWidth * 0.038).clamp(14.0, 18.0);
        final cardHeight = (constraints.maxHeight * 0.11).clamp(74.0, 92.0);
        final gap = (constraints.maxHeight * 0.018).clamp(10.0, 16.0);
        final topSpace = (constraints.maxHeight * 0.04).clamp(18.0, 30.0);

        return Container(
          color: AppColors.main,
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                  vertical: 8,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.main,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 24,
                            right: 18,
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 52,
                            right: 48,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.10),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 62,
                            left: 12,
                            child: Opacity(
                              opacity: 0.35,
                              child: Icon(
                                Icons.auto_awesome,
                                size: 86,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(panelPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: topSpace),
                                Text(
                                  'Start your Fitness Journey',
                                  style: AppTextStyles.h1.copyWith(
                                    color: AppColors.textOnMain,
                                    fontSize: titleSize,
                                  ),
                                ),
                                SizedBox(height: gap * 0.8),
                                Text(
                                  'Start your fitness journey\nwith our app\'s guidance and support.',
                                  style: AppTextStyles.helper.copyWith(
                                    color: AppColors.textOnMain.withOpacity(0.90),
                                    fontSize: bodySize,
                                    height: 1.35,
                                  ),
                                ),
                                SizedBox(height: gap * 1.8),
                                _JourneyCard(
                                  height: cardHeight,
                                  color: AppColors.statusLate,
                                  dayText: 'December, 11, 8am',
                                  title: 'WarmUp',
                                  subtitle: 'Run 02 km',
                                  icon: Icons.directions_run_rounded,
                                ),
                                SizedBox(height: gap),
                                _JourneyCard(
                                  height: cardHeight,
                                  color: AppColors.cardFood,
                                  dayText: 'December, 11, 8am',
                                  title: 'Food',
                                  subtitle: 'Run 02 km',
                                  icon: Icons.restaurant_rounded,
                                ),
                                SizedBox(height: gap),
                                _JourneyCard(
                                  height: cardHeight,
                                  color: AppColors.cardMedicine,
                                  dayText: 'December, 11, 8am',
                                  title: 'Medicine',
                                  subtitle: 'Run 02 km',
                                  icon: Icons.medication_rounded,
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: double.infinity,
                                  height: (constraints.maxHeight * 0.075)
                                      .clamp(50.0, 58.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.textOnMain,
                                      foregroundColor: AppColors.main,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        side: const BorderSide(
                                          color: AppColors.border,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    onPressed: onNext,
                                    child: Text(
                                      'Vamos lá >>>',
                                      style: AppTextStyles.button.copyWith(
                                        color: AppColors.main,
                                        fontSize: (constraints.maxWidth * 0.05)
                                            .clamp(18.0, 22.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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

class _JourneyCard extends StatelessWidget {
  final double height;
  final Color color;
  final String dayText;
  final String title;
  final String subtitle;
  final IconData icon;

  const _JourneyCard({
    required this.height,
    required this.color,
    required this.dayText,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayText,
                    style: AppTextStyles.helper.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.88),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    style: AppTextStyles.h3.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.helper.copyWith(
                      color: Colors.black.withOpacity(0.85),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 18,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}