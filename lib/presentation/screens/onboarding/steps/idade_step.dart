import 'package:flutter/material.dart';

class IdadeStep extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final Function(String) onChanged;

  const IdadeStep({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Qual seu nome?"),

        TextField(
          onChanged: onChanged,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: onBack, child: const Text("Voltar")),
            ElevatedButton(onPressed: onNext, child: const Text("Vamos lá")),
          ],
        ),
      ],
    );
  }
}