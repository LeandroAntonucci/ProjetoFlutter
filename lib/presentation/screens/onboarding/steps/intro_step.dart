import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class IntroStep extends StatelessWidget {
  final VoidCallback onNext;

  const IntroStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final maxPanelWidth = isMobile ? constraints.maxWidth : 520.0;

        final horizontalPadding = isMobile ? 16.0 : 24.0;
        final verticalPadding = isMobile ? 18.0 : 24.0;

        final titleSize = (constraints.maxWidth * 0.08).clamp(28.0, 38.0);
        final bodySize = (constraints.maxWidth * 0.035).clamp(14.0, 18.0);

        final cardHeight = (constraints.maxHeight * 0.11).clamp(72.0, 92.0);
        final gap = (constraints.maxHeight * 0.018).clamp(10.0, 16.0);

        return Container(
          color: AppColors.main,
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxPanelWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 12,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Container(
                      decoration: const BoxDecoration(color: AppColors.main),
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
                            bottom: 58,
                            left: 12,
                            child: Opacity(
                              opacity: 0.32,
                              child: Icon(
                                Icons.auto_awesome,
                                size: isMobile ? 72 : 88,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight:
                                    constraints.maxHeight -
                                    (verticalPadding * 2),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: verticalPadding,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: isMobile ? 20 : 28),
                                    Text(
                                      'Comece sua jornada de cuidados',
                                      style: AppTextStyles.h1.copyWith(
                                        color: AppColors.textOnMain,
                                        fontSize: titleSize,
                                        height: 1.08,
                                      ),
                                    ),
                                    SizedBox(height: gap * 0.8),
                                    Text(
                                      'Comece sua jornada\ncom nosso app\'s orientação e suporte.',
                                      style: AppTextStyles.helper.copyWith(
                                        color: AppColors.textOnMain.withOpacity(
                                          0.90,
                                        ),
                                        fontSize: bodySize,
                                        height: 1.35,
                                      ),
                                    ),
                                    SizedBox(height: gap * 1.5),
                                    _JourneyCard(
                                      height: cardHeight,
                                      color: AppColors.statusLate,
                                      dayText: 'December, 11, 8am',
                                      title: 'Aquecimento',
                                      subtitle: 'Corra 02 km',
                                      icon: Icons.directions_run_rounded,
                                    ),
                                    SizedBox(height: gap),
                                    _JourneyCard(
                                      height: cardHeight,
                                      color: AppColors.cardFood,
                                      dayText: 'December, 11, 8am',
                                      title: 'Comida',
                                      subtitle: 'Tomar café da manhã',
                                      icon: Icons.restaurant_rounded,
                                    ),
                                    SizedBox(height: gap),
                                    _JourneyCard(
                                      height: cardHeight,
                                      color: AppColors.cardMedicine,
                                      dayText: 'December, 11, 8am',
                                      title: 'Remédios',
                                      subtitle: 'Dipirona',
                                      icon: Icons.medication_rounded,
                                    ),
                                    SizedBox(height: gap * 1.4),
                                    Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: (constraints.maxHeight * 3)
                                            .clamp(50.0, 58.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.textOnMain,
                                            foregroundColor: AppColors.main,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              side: const BorderSide(
                                                color: AppColors.border,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          onPressed: onNext,
                                          child: Text(
                                            'Vamos lá >>>',
                                            style: AppTextStyles.button
                                                .copyWith(
                                                  color: AppColors.main,
                                                  fontSize:
                                                      (constraints.maxWidth *
                                                              0.05)
                                                          .clamp(18.0, 22.0),
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Container(
          constraints: BoxConstraints(minHeight: height),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
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
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          style: AppTextStyles.h3.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
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
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 18, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
