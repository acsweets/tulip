import 'package:flutter/material.dart';

class RouteObserverUtil {
  static CustomRouteObserver<PageRoute> routeObserver = CustomRouteObserver<PageRoute>();
}

class CustomRouteObserver<R extends Route<dynamic>> extends NavigatorObserver {
  final Map<R, Set<CustomRouteAware>> _listeners = <R, Set<CustomRouteAware>>{};

  /// Subscribe [routeAware] to be informed about changes to [route].
  ///
  /// Going forward, [routeAware] will be informed about qualifying changes
  /// to [route], e.g. when [route] is covered by another route or when [route]
  /// is popped off the [Navigator] stack.
  void subscribe(CustomRouteAware routeAware, R route) {
    final Set<CustomRouteAware> subscribers = _listeners.putIfAbsent(route, () => <CustomRouteAware>{});
    if (subscribers.add(routeAware)) {}
  }

  /// Unsubscribe [routeAware].
  ///
  /// [routeAware] is no longer informed about changes to its route. If the given argument was
  /// subscribed to multiple types, this will unregister it (once) from each type.
  void unsubscribe(CustomRouteAware routeAware) {
    for (R route in _listeners.keys) {
      final Set<CustomRouteAware>? subscribers = _listeners[route];
      subscribers?.remove(routeAware);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is R && previousRoute is R) {
      final List<CustomRouteAware>? previousSubscribers = _listeners[previousRoute]?.toList();

      if (previousSubscribers != null) {
        for (CustomRouteAware routeAware in previousSubscribers) {
          routeAware.didPop(route, previousRoute);
        }
      }

      final List<CustomRouteAware>? subscribers = _listeners[route]?.toList();

      if (subscribers != null) {
        for (CustomRouteAware routeAware in subscribers) {
          routeAware.didPop(route, previousRoute);
        }
      }
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is R && previousRoute is R) {
      final List<CustomRouteAware>? subscribers = _listeners[route]?.toList();

      if (subscribers != null) {
        for (CustomRouteAware routeAware in subscribers) {
          routeAware.didPush(route, previousRoute);
        }
      }

      final List<CustomRouteAware>? previousSubscribers = _listeners[previousRoute]?.toList();

      if (previousSubscribers != null) {
        for (CustomRouteAware routeAware in previousSubscribers) {
          routeAware.didPush(route, previousRoute);
        }
      }
    }
  }
}

/// An interface for objects that are aware of their current [Route].
///
/// This is used with [CustomRouteObserver] to make a widget aware of changes to the
/// [Navigator]'s session history.
abstract class CustomRouteAware {
  /// Called when the current route has been pushed.
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {}

  /// Called when the current route has been popped off.
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {}
}
