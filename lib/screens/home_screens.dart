import 'package:example_isis24_app/screens/index.dart';
import 'package:example_isis24_app/services/local_db_services.dart';
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
    ),
    _HomeBody(content: ProfileScreen()),
    _HomeBody(content: ShoppingCartScreen()),
    _HomeBody(content: WishlistScreen()),
  ];

  final List<Widget> _screen = [
    PrincipalScreen(),
    ProfileScreen(),
    ShoppingCartScreen(),
    WishlistScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    LocalDbServices.db.database;
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

  const _HomeBody({required this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TitleHome(),
          Expanded(
              child: SingleChildScrollView(
            child: content,
          ))
        ],
      ),
    );
  }
}
