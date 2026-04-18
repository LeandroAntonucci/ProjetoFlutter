import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dados simulados (No futuro, virão do seu Provider/Controller)
    final String userName = "Joselda";
    final String todayDate = "11, December";
    final String progress = "2 de 3";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // Permite scroll sem quebrar layout
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER (FIXO) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Olá! $userName",
                        style: AppTextStyles.h2.copyWith(
                          color: const Color(
                            0xFF003366,
                          ), // Azul escuro da imagem
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "TODAY IS",
                        style: AppTextStyles.helper.copyWith(
                          fontSize: 12,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        todayDate,
                        style: AppTextStyles.h1.copyWith(fontSize: 28),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://placeholder.com',
                    ), // Foto do usuário
                  ),
                ],
              ),

              // --- INDICADOR DE PROGRESSO ---
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    const Expanded(child: Divider(thickness: 1.5)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        progress,
                        style: AppTextStyles.h3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(thickness: 1.5)),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // --- LISTA DE CARDS ---
              // Aqui simulamos a lista que viria do seu banco de dados
              _TaskCard(
                category: "Remédio de ***",
                title: "Tadalafila",
                time: "08:00",
                status: "Pendente",
                accentColor: AppColors.cardMedicine,
                icon: LucideIcons.accessibility,
                buttonText: "Marcar como feito",
              ),

              _TaskCard(
                category: "Refeição - 00:00",
                title: "Refeição",
                time: "08:00",
                status: "Pendente",
                accentColor: AppColors.cardFood,
                icon: LucideIcons.accessibility,
                buttonText: "Marcar como tomado",
              ),

              _TaskCard(
                category: "Exercício - 00:00",
                title: "Exercício",
                time: "08:00",
                status: "Pendente",
                accentColor: AppColors.cardExercise,
                icon: LucideIcons.bellRing,
                buttonText: "Concluído",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final String category;
  final String title;
  final String time;
  final String status;
  final Color accentColor;
  final IconData icon;
  final String buttonText;

  const _TaskCard({
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
          // Barra lateral colorida
          Container(
            width: 35,
            height: 180, // Altura fixa ou calculada
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
                  // Botão de ação
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
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
