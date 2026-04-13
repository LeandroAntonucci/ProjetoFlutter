import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final maxCardWidth = size.width < 600 ? size.width * 0.92 : 420.0;
    final cardHeight = size.height < 700 ? size.height * 0.90 : 620.0;
    final topBarHeight = (size.height * 0.06).clamp(40.0, 56.0);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 420,
              minWidth: 280,
              maxHeight: cardHeight,
            ),
            child: FractionallySizedBox(
              widthFactor: size.width < 600 ? 0.92 : 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Column(
                    children: [
                      Container(
                        height: topBarHeight,
                        width: double.infinity,
                        color: AppColors.main,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 28,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 92,
                                height: 92,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE6F4F4),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.check_rounded,
                                    size: 54,
                                    color: AppColors.main,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28),
                              Text(
                                'Password Changed!',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.h2.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Your password has been changed\nsuccessfully.',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.body.copyWith(
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 28),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.main,
                                    foregroundColor: AppColors.textOnMain,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      side: const BorderSide(
                                        color: AppColors.border,
                                        width: 1,
                                      ),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.login,
                                      (route) => false,
                                    );
                                  },
                                  child: Text(
                                    'Back to Login',
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}