import 'package:example_isis24_app/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xff5e18db),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
      )),
      title: 'Movil App',
      initialRoute: '/home',
      onGenerateRoute: AppNavigation.onGenerateRoute,
    );
  }
}
