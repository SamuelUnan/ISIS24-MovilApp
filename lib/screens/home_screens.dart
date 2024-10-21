import 'package:example_isis24_app/screens/index.dart';

import 'package:example_isis24_app/widgets/index.dart';
import 'package:flutter/material.dart';

class HomeScreens extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreens> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    _HomeBody(
      content: PrincipalScreen(),
      title: 'Catálogo de Productos',
      subtitle: 'Listado de Productos',
    ),
    _HomeBody(
        content: ShoppingCartScreen2(),
        title: 'Carrito de Compras',
        subtitle: 'Productos en el Carrito'),
    _HomeBody(content: ShoppingCartScreen(), title: '', subtitle: ''),
    _HomeBody(content: WishlistScreen(), title: '', subtitle: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [BackgroundHome(), _screens[_currentIndex]],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  final Widget content;
  final String title;
  final String subtitle;

  const _HomeBody(
      {required this.content, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TitleHome(
            Title: title,
            Subtitle: subtitle,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: content,
          ))
        ],
      ),
    );
  }
}
