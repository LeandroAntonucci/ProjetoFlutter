import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/top_curve_green_widget.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../core/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;
  bool obscurePassword = true;
  String? errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
      errorMessage = null;
    });

    try {
      final auth = context.read<AuthService>();
      await auth.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Não foi possível fazer login.';
      });
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < 600;

    final cardWidth = isMobile ? size.width : 420.0;
    final cardHeight = size.height;
    final bodyHorizontalPadding = isMobile ? 20.0 : 28.0;
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
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ClipRRect(
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
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(
                            bodyHorizontalPadding,
                            14,
                            bodyHorizontalPadding,
                            18,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Realize o Login',
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
                                  validator: (value) {
                                    final email = value?.trim() ?? '';
                                    if (email.isEmpty) {
                                      return 'Informe seu email.';
                                    }
                                    if (!email.contains('@') || !email.contains('.')) {
                                      return 'Informe um email válido.';
                                    }
                                    return null;
                                  },
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
                                  onFieldSubmitted: (_) => _submitLogin(),
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
                                      tooltip: obscurePassword
                                          ? 'Mostrar senha'
                                          : 'Ocultar senha',
                                      onPressed: () {
                                        setState(() {
                                          obscurePassword = !obscurePassword;
                                        });
                                      },
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
                                  validator: (value) {
                                    final password = value ?? '';
                                    if (password.isEmpty) {
                                      return 'Informe sua senha.';
                                    }
                                    if (password.length < 6) {
                                      return 'A senha deve ter ao menos 6 caracteres.';
                                    }
                                    return null;
                                  },
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
                                    onPressed: loading ? null : _submitLogin,
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
                                            'Entrar',
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
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.register,
                                      );
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Não tem uma conta ainda? ',
                                        style: AppTextStyles.helper.copyWith(
                                          color: Colors.grey.shade700,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Se inscreva',
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