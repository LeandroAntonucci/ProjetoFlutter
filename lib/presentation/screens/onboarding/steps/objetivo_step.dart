import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ObjetivoStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final Function(String) onChanged;

  const ObjetivoStep({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.onChanged,
  });

  @override
  State<ObjetivoStep> createState() => _ObjetivoStepState();
}

class _ObjetivoStepState extends State<ObjetivoStep> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Topo (voltar + progress)
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: widget.onBack,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // 🔹 Progress bar
                  Expanded(
                    child: Row(
                      children: [
                        _buildProgress(true),
                        _buildProgress(true),
                        _buildProgress(false, active: true),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // 🔹 Título
              Text(
                'What do you want to\nachieve?',
                style: AppTextStyles.h2.copyWith(color: Colors.black),
              ),

              const SizedBox(height: 10),

              // 🔹 Subtexto
              Text(
                'What you are going to select will\n effect your workout program',
                style: AppTextStyles.helper.copyWith(color: Colors.black54),
              ),

              const SizedBox(height: 30),

              // 🔹 Opções
              _optionCard(
                text: 'Quero utilizar para lembrar dos meus remédios',
                isSelected: selected == 'remedios',
                onTap: () {
                  setState(() => selected = 'remedios');
                  widget.onChanged('remedios');
                },
              ),

              const SizedBox(height: 16),

              _optionCard(
                text: 'Vou gerenciar membros da familia',
                isSelected: selected == 'familia',
                onTap: () {
                  setState(() => selected = 'familia');
                  widget.onChanged('familia');
                },
              ),

              const Spacer(),

              // 🔹 Botão
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.main,
                    foregroundColor: AppColors.textOnMain,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  onPressed: selected == null ? null : widget.onNext,
                  child: Text(
                    'Avançar  >>>',
                    style: AppTextStyles.button.copyWith(
                      color: AppColors.textOnMain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Card opção
  Widget _optionCard({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          text,
          style: AppTextStyles.body.copyWith(color: Colors.black),
        ),
      ),
    );
  }

  // 🔹 Progress indicador
  Widget _buildProgress(bool filled, {bool active = false}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 4,
        decoration: BoxDecoration(
          color: active
              ? Colors.black
              : filled
              ? AppColors.main.withOpacity(0.4)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
