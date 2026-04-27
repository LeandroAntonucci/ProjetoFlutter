import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';

class TaskSuccessScreen extends StatelessWidget {
  const TaskSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, size: 80, color: Colors.green),

                const SizedBox(height: 20),

                const Text(
                  'Task criada com sucesso!',
                  style: TextStyle(fontSize: 20),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.tasks,
                        (route) => false,
                      );
                    },
                    child: const Text('Adicionar mais tasks'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}