import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart'; // Necessário para o context.read
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../core/services/auth_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isLoading = false;

  
  Future<void> _handleLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair'),
        content: const Text('Deseja realmente sair da sua conta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sair', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      try {
        final auth = context.read<AuthService>();
        await auth.logout(); 
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao sair. Tente novamente.')),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

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
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            children: [
              _buildMenuItem(
                icon: LucideIcons.lock,
                title: 'Configurações da senha',
                onTap: () => Navigator.pushNamed(context, AppRoutes.resetPassword),
              ),
              _buildDivider(),
              _buildMenuItem(
                icon: LucideIcons.userX,
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
                title: 'Suporte',
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
                title: 'Política de privacidade',
                trailing: const Icon(LucideIcons.externalLink, size: 20, color: AppColors.main),
                onTap: () {},
              ),
              _buildDivider(),
              _buildMenuItem(
                icon: LucideIcons.logOut,
                title: 'Sair',
                onTap: _handleLogout, 
              ),
            ],
          ),
    );
  }

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

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(color: Color(0xFFF0F0F0), thickness: 1),
    );
  }
}
