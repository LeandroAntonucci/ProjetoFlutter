import 'package:flutter/material.dart';


class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Minhas Tasks"),

        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/tasks/type');
          },
          child: const Text("Adicionar Task"),
        ),
      ],
    );
  }
}