import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
              maxWidth: maxCardWidth,
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
                      // 🔹 Top Bar
                      Container(
                        height: topBarHeight,
                        width: double.infinity,
                        color: AppColors.main,
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🔹 Botão voltar
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back_ios_new),
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.login,
                                      (route) => false,
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 24),

                              // 🔹 Título
                              Text(
                                'Esqueceu\nsua senha',
                                style: AppTextStyles.h2.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),

                              const SizedBox(height: 12),

                              // 🔹 Subtexto
                              Text(
                                'Adicione o código de verificação que acabamos de enviar no seu Email.',
                                style: AppTextStyles.body.copyWith(
                                  color: Colors.black54,
                                ),
                              ),

                              const SizedBox(height: 28),

                              // 🔹 Label Email
                              Text(
                                'Email',
                                style: AppTextStyles.body.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),

                              const SizedBox(height: 8),

                              // 🔹 Input
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'demo@email.com',
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  border: const UnderlineInputBorder(),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.main,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),

                              const Spacer(),

                              // 🔹 Botão
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.main,
                                    foregroundColor: AppColors.textOnMain,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.resetPassword,
                                      (route) => false,
                                    );
                                  },
                                  child: Text(
                                    'Receber código',
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
