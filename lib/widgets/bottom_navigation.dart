import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigation(
      {required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        
        type: BottomNavigationBarType.fixed,
        //showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Carrito de Compras'),
          BottomNavigationBarItem(icon: Icon(Icons.monitor_heart_rounded), label: 'Lista de Deseos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil')
        ]);
  }
}
