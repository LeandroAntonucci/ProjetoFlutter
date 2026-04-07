import 'package:flutter/material.dart';


class FinalStep extends StatelessWidget {
  final String nome;
  final VoidCallback onFinish;

  const FinalStep({
    super.key,
    required this.nome,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Tudo pronto, $nome!"),
          ElevatedButton(
            onPressed: onFinish,
            child: const Text("Começar"),
          ),
        ],
      ),
    );
  }
}