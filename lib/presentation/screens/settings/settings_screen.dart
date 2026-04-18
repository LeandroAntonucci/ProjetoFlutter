import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart'; // Sugestão para ícones parecidos com a imagem
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Configurações',
          style: AppTextStyles.h2.copyWith(color: AppColors.textOnWhite),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          _buildMenuItem(
            icon: LucideIcons.bell,
            title: 'Configurações da senha',
            onTap: () => Navigator.pushNamed(context, AppRoutes.resetPassword),
          ),
          _buildDivider(),
          _buildMenuItem(
          icon: LucideIcons.user,
            title: 'Deletar conta',
            onTap: () {
              // Lógica para deletar conta
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: LucideIcons.bell,
            title: 'Gerenciar notificações',
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: LucideIcons.helpCircle,
            title: 'Supporte',
            trailing: const Icon(LucideIcons.externalLink, size: 20, color: AppColors.cardExercise),
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: LucideIcons.smartphone,
            title: 'Acessibilidade',
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: LucideIcons.scroll,
            title: 'Politica de privacidade',
            trailing: const Icon(LucideIcons.externalLink, size: 20, color: AppColors.main),
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: LucideIcons.logOut,
            title: 'Sair',
            onTap: () {
             Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para construir os itens da lista
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey, size: 24),
      title: Text(
        title,
        style: AppTextStyles.body.copyWith(
          color: const Color(0xFF1A1A40), 
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }

  // Divisor customizado conforme a imagem
  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(color: Color(0xFFF0F0F0), thickness: 1),
    );
  }
}
