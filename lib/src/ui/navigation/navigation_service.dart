import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateWithoutGoBack(String routeName) {
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  Future<dynamic> navigateAndRemoveUntil(
      String routeName, String routeNameUntil) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, (route) => route == routeNameUntil);
  }

  Future<dynamic> navigateAndRemove(String routeName) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }

  Future<dynamic> goBac(String routeName) {
    return navigatorKey.currentState.popAndPushNamed(routeName);
  }
}
