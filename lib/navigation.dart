import 'package:flutter/material.dart';
import 'screens/index.dart';

class AppNavigation {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeScreens());
      case 'cart':
        return MaterialPageRoute(builder: (_) => ShoppingCartScreen());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case 'register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreens());
    }
  }
}
