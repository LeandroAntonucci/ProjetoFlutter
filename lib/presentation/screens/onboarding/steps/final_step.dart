import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class FinalStep extends StatelessWidget {
  final String nome;
  final VoidCallback onFinish;

  const FinalStep({super.key, required this.nome, required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.main
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // 🔹 Título
              Text(
                'Você está\npronto para ir!',
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.textOnMain,
                  fontSize: 30,
                ),
              ),

              const SizedBox(height: 12),

              // 🔹 Subtexto
              Text(
                'Start your fitness journey\nwith our app’s guidance and support.',
                style: AppTextStyles.helper.copyWith(
                  color: AppColors.textOnMain.withOpacity(0.9),
                ),
              ),

              const Spacer(),

              // 🔹 Ilustração (placeholder)
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5, 
                width: MediaQuery.of(context).size.width * 0.5, 
                child: Image.asset(
                  'assets/images/congrats.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

              const Spacer(),

              // 🔹 Botão
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.main,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  onPressed: onFinish,
                  child: Text(
                    'Vamos lá  >>>',
                    style: AppTextStyles.button.copyWith(
                      color: AppColors.main,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
