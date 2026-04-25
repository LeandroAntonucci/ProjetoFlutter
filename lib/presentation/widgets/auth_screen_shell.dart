import 'package:flutter/material.dart';

import 'top_curve_green_widget.dart';
import '../../core/constants/app_colors.dart';

class AuthScreenShell extends StatelessWidget {
  const AuthScreenShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < 600;

    final cardWidth = isMobile ? size.width : 420.0;
    final cardHeight = size.height;
    final topSectionHeight = (size.height * 0.34).clamp(220.0, 320.0);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 420,
              minWidth: isMobile ? size.width : 320,
              maxHeight: cardHeight,
            ),
            child: SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: topSectionHeight,
                      width: double.infinity,
                      child: ClipPath(
                        clipper: TopCurveClipper(),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.main,
                                Color(0xFF00C9A7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: child),
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