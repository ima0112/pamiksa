import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateToWithArguments(String routeName, String argument) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: argument);
  }

  Future<dynamic> navigateWithoutGoBack(String routeName) {
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  Future<dynamic> navigateAndRemoveUntil(String routeName) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, ModalRoute.withName('/login'));
  }

  Future<dynamic> navigateAndRemove(String routeName) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
