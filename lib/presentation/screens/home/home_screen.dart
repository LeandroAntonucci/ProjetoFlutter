import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/task_card_widget.dart';

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
            
              TaskCard(
                category: "Remédio de ***",
                title: "Tadalafila",
                time: "08:00",
                status: "Pendente",
                accentColor: AppColors.cardMedicine,
                icon: LucideIcons.accessibility,
                buttonText: "Marcar como feito",
              ),

              TaskCard(
                category: "Refeição - 00:00",
                title: "Refeição",
                time: "08:00",
                status: "Pendente",
                accentColor: AppColors.cardFood,
                icon: LucideIcons.accessibility,
                buttonText: "Marcar como tomado",
              ),

              TaskCard(
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

