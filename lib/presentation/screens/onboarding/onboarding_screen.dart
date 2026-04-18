import 'package:flutter/material.dart';
import './steps/steps.dart';
import '../../../routes/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  // Estado do usuário (compartilhado)
  String nome = '';
  int idade = 0;
  double peso = 0;
  String objetivo = '';

  int currentPage = 0;

  void nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void previousPage() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() => currentPage = index);
        },
        children: [
          IntroStep(onNext: nextPage),

          NomeStep(
            onNext: nextPage,
            onBack: previousPage,
            onChanged: (v) => nome = v,
          ),

          IdadeStep(
            onNext: nextPage,
            onBack: previousPage,
            onChanged: (v) => idade = v,
          ),

          PesoStep(
            onNext: nextPage,
            onBack: previousPage,
            onChanged: (v) => peso = v,
          ),

          ObjetivoStep(
            onNext: nextPage,
            onBack: previousPage,
            onChanged: (v) => objetivo = v,
          ),

          FinalStep(
            nome: nome,
            onFinish: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.main,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
