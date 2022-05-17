import 'package:flutter/material.dart';

enum Direction { left, right }

class RouteName {
  static const HOME = "/homePage";
  static const BLITZLICHT = "/blitzlichtPage";
  static const RATING = "/ratingPage";
  static const SETTINGS = "/settingsPage";
  static const TOPIC = "/topicPage";
  static const LEGAL = "/legalInfoPage";
  static const PRIVACY = "/privacyPage";
}

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo({String routeName, Object arguments}) {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }
}
