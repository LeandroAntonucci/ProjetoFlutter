import 'package:flutter/material.dart';

import '../../widgets/top_curve_green_widget.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final isMobile = size.width < 600;
    final isTablet = size.width < 1024;

    final maxWidth = isMobile
        ? size.width
        : isTablet
        ? 500.0
        : 420.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: maxWidth,
          height: size.height * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              SizedBox(
                height: size.height * 0.35,
                width: double.infinity,
                child: ClipPath(
                  clipper: TopCurveClipper(),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.main, Color(0xFF00C9A7)],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Spacer(),

                    Text(
                      "Welcome",
                      style: AppTextStyles.h1.copyWith(
                        color: AppColors.textOnWhite,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Lorem ipsum dolor sit amet",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.main,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.login);
                        },
                        child: Text(
                          "Avançar",
                          style: AppTextStyles.button.copyWith(
                            color: AppColors.textOnMain,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
