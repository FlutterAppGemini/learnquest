import 'package:flutter/material.dart';
import 'package:learnquest/feature/auth/page/auth_page.dart';
import 'package:learnquest/feature/home/page/home_page.dart';
import 'package:learnquest/feature/welcome/page/welcome_page.dart';

class Routes {
  static const String welcome = 'welcome';
  static const String home = 'home';
  static const String auth = 'auth';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return _buildFadeRoute(const WelcomePage(), settings);
      case home:
        return _buildFadeRoute(const HomePage(), settings);
      case auth:
        return _buildFadeRoute(const AuthPage(), settings);
      default:
        return _buildFadeRoute(
          const Scaffold(
            body: Center(
              child: Text('No Page Route Provided'),
            ),
          ),
          settings,
        );
    }
  }

  static PageRouteBuilder _buildFadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      settings: settings,
    );
  }
}
