import 'package:flutter/material.dart';

class IntroStep extends StatelessWidget {
  final VoidCallback onNext;

  const IntroStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Bem-vindo!"),
          ElevatedButton(
            onPressed: onNext,
            child: const Text("Vamos lá"),
          ),
        ],
      ),
    );
  }
}