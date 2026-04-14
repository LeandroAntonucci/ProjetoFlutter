import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
                      // 🔹 Top bar
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
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),

                              const SizedBox(height: 24),

                              // 🔹 Título
                              Text(
                                'Esqueceu\nsua senha',
                                style: AppTextStyles.h1.copyWith(
                                  color: Colors.black,
                                ),
                              ),

                              const SizedBox(height: 12),

                              // 🔹 Descrição
                              Text(
                                'Adicione o código de verificação que acabamos de enviar no seu Email.',
                                style: AppTextStyles.helper.copyWith(
                                  color: Colors.black54,
                                ),
                              ),

                              const SizedBox(height: 40),

                              // 🔹 Campos OTP
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(4, (index) {
                                  return SizedBox(
                                    width: 60,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      style: AppTextStyles.h2,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.main,
                                            width: 3,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.main,
                                            width: 3,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),

                              const Spacer(),

                              // 🔹 Botão validar
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
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.passwordResetedOk,
                                    );
                                  },
                                  child: Text(
                                    'Validar',
                                    style: AppTextStyles.button.copyWith(
                                      color: AppColors.textOnMain,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // 🔹 Resend
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Didn't received code? ",
                                    style: AppTextStyles.helper.copyWith(
                                      color: Colors.black54,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Resend",
                                        style: AppTextStyles.helper.copyWith(
                                          color: AppColors.main,
                                          fontWeight: FontWeight.w600,
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
