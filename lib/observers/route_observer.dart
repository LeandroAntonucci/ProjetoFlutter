import 'package:flutter/material.dart';

/// Tipos de eventos de rota: push, pop, replace
enum RouteEventType { push, pop, replace }

/// Representa um evento de rota registrado pelo sistema
class RouteEvent {
  final RouteEventType type;
  final String routeName;

  RouteEvent({required this.type, required this.routeName});
}

/// Controller de rotas que observa a navegação global
/// e notifica mudanças via ValueNotifier
class AppRouteObserver extends NavigatorObserver {
  // Construtor privado do singleton
  AppRouteObserver._();

  // Instância única acessível globalmente
  static final AppRouteObserver instance = AppRouteObserver._();

  // Factory para acesso mais intuitivo (opcional)
  factory AppRouteObserver() => instance;

  /// Notificador com a lista atual de rotas ativas
  final ValueNotifier<List<Route<dynamic>>> routes = ValueNotifier([]);

  /// Notificador com o último evento de rota registrado
  final ValueNotifier<RouteEvent?> lastEvent = ValueNotifier(null);

  /// Lista de nomes de rotas que devem ser ignoradas (não monitoradas)
  final List<String> _ignoredRoutes = ['face-auth'];

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);

    if (_shouldTrack(route)) {
      final updated = List<Route<dynamic>>.from(routes.value);
      if (!updated.any((r) => r.settings.name == route.settings.name)) {
        updated.add(route);
        routes.value = updated;
      }

      final name = route.settings.name ?? 'Unknown';
      lastEvent.value = RouteEvent(type: RouteEventType.push, routeName: name);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    if (_shouldTrack(route)) {
      final updated = List<Route<dynamic>>.from(routes.value)..remove(route);
      routes.value = updated;

      final name = route.settings.name ?? 'Unknown';
      lastEvent.value = RouteEvent(type: RouteEventType.pop, routeName: name);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    if (_shouldTrack(newRoute) && oldRoute != null && newRoute != null) {
      final updated = List<Route<dynamic>>.from(routes.value);
      final index = updated.indexOf(oldRoute);
      if (index != -1) {
        updated[index] = newRoute;
      } else {
        updated.add(newRoute);
      }
      routes.value = updated;

      final name = newRoute.settings.name ?? 'Unknown';
      lastEvent.value = RouteEvent(
        type: RouteEventType.replace,
        routeName: name,
      );
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);

    if (_shouldTrack(route)) {
      final updated = List<Route<dynamic>>.from(routes.value)..remove(route);
      routes.value = updated;
    }
  }

  /// Define se a rota deve ser monitorada
  bool _shouldTrack(Route? route) {
    return route != null &&
        route is! ModalBottomSheetRoute &&
        !_ignoredRoutes.contains(route.settings.name);
  }
}