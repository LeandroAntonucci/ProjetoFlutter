import 'package:flutter/material.dart';
import '../../observers/route_observer.dart';

/// Widget informativo que exibe:
/// - Lista numerada de rotas abertas
/// - Último evento de navegação registrado
class RouteDebugWidget extends StatelessWidget {
  const RouteDebugWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final observer = AppRouteObserver.instance;

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle('📋 Rotas Abertas'),
            const SizedBox(height: 8),
            _buildRouteList(observer.routes),

            const Divider(height: 32),

            _buildTitle('🕹️ Último Evento de Navegação'),
            const SizedBox(height: 8),
            _buildLastEvent(observer.lastEvent),
          ],
        ),
      ),
    );
  }

  /// Título de seção estilizado
  Widget _buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  /// Widget que exibe a lista numerada de rotas
  Widget _buildRouteList(ValueNotifier<List<Route<dynamic>>> routesNotifier) {
    return ValueListenableBuilder<List<Route<dynamic>>>(
      valueListenable: routesNotifier,
      builder: (context, routes, _) {
        if (routes.isEmpty) {
          return const Text('Nenhuma rota aberta no momento.');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              routes.asMap().entries.map((entry) {
                final index = entry.key + 1;
                final name = entry.value.settings.name ?? 'Sem nome';
                return Text('$index. $name');
              }).toList(),
        );
      },
    );
  }

  /// Widget que exibe o último evento registrado
  Widget _buildLastEvent(ValueNotifier<RouteEvent?> eventNotifier) {
    return ValueListenableBuilder<RouteEvent?>(
      valueListenable: eventNotifier,
      builder: (context, event, _) {
        if (event == null) {
          return const Text('Nenhum evento registrado ainda.');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRichLabel('Tipo: ', _formatEventType(event.type)),
            _buildRichLabel('Rota: ', event.routeName),
          ],
        );
      },
    );
  }

  /// Formata o tipo do evento de forma legível
  String _formatEventType(RouteEventType type) {
    switch (type) {
      case RouteEventType.push:
        return 'Push (Nova rota)';
      case RouteEventType.pop:
        return 'Pop (Voltar)';
      case RouteEventType.replace:
        return 'Replace (Substituição)';
    }
  }

  /// Cria uma linha com destaque no rótulo
  Widget _buildRichLabel(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black87),
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

// class BrasilPage extends StatelessWidget {
//   const BrasilPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Brasil')),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: const [
//             Text('Bem-vindo ao Brasil!'),
//             SizedBox(height: 16),
//             RouteDebugWidget(),
//             SizedBox(height: 16),
//             RouteListWidget(),
//           ],
//         ),
//       ),
//     );
//   }
// }