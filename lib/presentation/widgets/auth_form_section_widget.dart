import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class AuthFormSection extends StatelessWidget {
  const AuthFormSection({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.loading,
    required this.errorMessage,
    required this.obscurePassword,
    required this.onTogglePasswordVisibility,
    required this.onSubmit,
    required this.emailValidator,
    required this.passwordValidator,
    required this.primaryButtonText,
    required this.bottomTextPrefix,
    required this.bottomActionText,
    required this.onBottomTap,
    required this.title,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool loading;
  final String? errorMessage;
  final bool obscurePassword;

  final VoidCallback onTogglePasswordVisibility;
  final Future<void> Function() onSubmit;
  final String? Function(String?) emailValidator;
  final String? Function(String?) passwordValidator;

  final String primaryButtonText;
  final String bottomTextPrefix;
  final String bottomActionText;
  final VoidCallback onBottomTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < 600;
    final horizontalPadding = isMobile ? 20.0 : 28.0;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 14, horizontalPadding, 18),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.h1.copyWith(
                color: Colors.black,
                fontSize: (size.width * 0.075).clamp(26.0, 34.0),
              ),
            ),
            const SizedBox(height: 26),
            Text(
              'Email',
              style: AppTextStyles.helper.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              style: AppTextStyles.inputText.copyWith(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: 'nome@email.com',
                hintStyle: AppTextStyles.inputPlaceholder.copyWith(
                  color: Colors.grey.shade500,
                ),
                filled: true,
                fillColor: AppColors.inputBackground,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  size: 18,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppColors.border,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppColors.main,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppColors.statusLate,
                    width: 1.5,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppColors.statusLate,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              validator: emailValidator,
            ),
            const SizedBox(height: 18),
            Text(
              'Senha',
              style: AppTextStyles.helper.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: passwordController,
              obscureText: obscurePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSubmit(),
              style: AppTextStyles.inputText.copyWith(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: 'Digite sua senha',
                hintStyle: AppTextStyles.inputPlaceholder.copyWith(
                  color: Colors.grey.shade500,
                ),
                filled: true,
                fillColor: AppColors.inputBackground,
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  size: 18,
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                  tooltip: obscurePassword ? 'Mostrar senha' : 'Ocultar senha',
                  onPressed: onTogglePasswordVisibility,
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey.shade700,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppColors.border,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppColors.main,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppColors.statusLate,
                    width: 1.5,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppColors.statusLate,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              validator: passwordValidator,
            ),
            const SizedBox(height: 16),
            if (errorMessage != null) ...[
              Text(
                errorMessage!,
                style: AppTextStyles.helper.copyWith(
                  color: AppColors.statusLate,
                ),
              ),
              const SizedBox(height: 12),
            ],
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.main,
                  foregroundColor: AppColors.textOnMain,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(
                      color: AppColors.border,
                      width: 1,
                    ),
                  ),
                ),
                onPressed: loading ? null : () => onSubmit(),
                child: loading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: AppColors.textOnMain,
                        ),
                      )
                    : Text(
                        primaryButtonText,
                        style: AppTextStyles.button.copyWith(
                          color: AppColors.textOnMain,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: onBottomTap,
                child: RichText(
                  text: TextSpan(
                    text: bottomTextPrefix,
                    style: AppTextStyles.helper.copyWith(
                      color: Colors.grey.shade700,
                    ),
                    children: [
                      TextSpan(
                        text: bottomActionText,
                        style: AppTextStyles.helper.copyWith(
                          color: AppColors.main,
                          fontWeight: FontWeight.w700,
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
    );
  }
}