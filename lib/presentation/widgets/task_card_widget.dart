import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class TaskCard extends StatelessWidget {
  final String category;
  final String title;
  final String time;
  final String status;
  final Color accentColor;
  final IconData icon;
  final String buttonText;

  const TaskCard({super.key,  
    required this.category,
    required this.title,
    required this.time,
    required this.status,
    required this.accentColor,
    required this.icon,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 220, 
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                bottomLeft: Radius.circular(22),
              ),
            ),
          ),
          // Conteúdo do Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: accentColor,
                        radius: 15,
                        child: Icon(icon, size: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black, thickness: 3),
                  Text(
                    "95/100",
                    style: AppTextStyles.helper.copyWith(fontSize: 10),
                  ),
                  Text(
                    title,
                    style: AppTextStyles.h3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "$time | $status",
                    style: AppTextStyles.helper.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Text(
                    "Atenção:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {}, // Lógica de concluir tasks
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        buttonText,
                        style: AppTextStyles.button.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
