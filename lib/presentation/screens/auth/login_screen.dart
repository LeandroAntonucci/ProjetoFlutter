import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/top_curve_green_widget.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final auth = context.read<AuthService>();

    final maxWidth = size.width < 600 ? size.width : 420.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: maxWidth,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              // 🔹 Fundo verde com curva
              ClipPath(
                clipper: TopCurveClipper(),
                child: Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00DDAE), Color(0xFF00C9A7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
               // 🔹 Conteúdo
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 180),

                    const Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // EMAIL
                    const Text("Email"),
                    const SizedBox(height: 5),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "demo@email.com",
                        border: UnderlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // PASSWORD
                    const Text("Password"),
                    const SizedBox(height: 5),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(Icons.visibility_off),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // BOTÃO
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF00DDAE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("Entrar"),
                      ),
                    ),

                    const Spacer(),

                    // SIGN UP
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: RichText(
                          text: const TextSpan(
                            text: "Don't have an Account? ",
                            style: TextStyle(color: Colors.grey),
                            children: [
                              TextSpan(
                                text: "Sign up",
                                style: TextStyle(
                                  color: Color(0xFF00DDAE),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
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