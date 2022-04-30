
import 'package:flutter/material.dart';
import 'package:my_bili/common/utils/log_utils.dart';

/// 全局监听路由
class MyRouteObserver<R extends Route<dynamic>> extends RouteObserver<R> {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    loggerNoStack.e('didPush route: ${route.settings.name},previousRoute:${previousRoute?.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    loggerNoStack.e('didPop route: ${route.settings.name},previousRoute:${previousRoute?.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    loggerNoStack.e('didReplace newRoute: ${newRoute?.settings.name},oldRoute:${oldRoute?.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    loggerNoStack.e('didRemove route: ${route.settings.name},previousRoute:${previousRoute?.settings.name}');
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    loggerNoStack.e('didStartUserGesture route: ${route.settings.name},previousRoute:${previousRoute?.settings.name}');
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    loggerNoStack.e('didStopUserGesture');
  }
}

