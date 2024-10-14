import 'package:flutter/material.dart';

class PrincipalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _SingleCard(
            color: Colors.white,
            icon: Icons.access_alarm,
            text: 'Producto A',
          ),
          _SingleCard(
            color: Colors.white,
            icon: Icons.access_alarm,
            text: 'Producto A',
          )
        ]),
        TableRow(children: [
          _SingleCard(
            color: Colors.white,
            icon: Icons.access_alarm,
            text: 'Producto A',
          ),
          _SingleCard(
            color: Colors.white,
            icon: Icons.access_alarm,
            text: 'Producto A',
          )
        ]),
        TableRow(children: [
          _SingleCard(
            color: Colors.white,
            icon: Icons.access_alarm,
            text: 'Producto A',
          ),
          _SingleCard(
            color: Colors.white,
            icon: Icons.access_alarm,
            text: 'Producto A',
          )
        ]),
        TableRow(children: [
          _SingleCard(
            color: Colors.white,
            icon: Icons.access_alarm,
            text: 'Producto A',
          ),
          _SingleCard(
            color: Colors.white,
            icon: Icons.access_alarm,
            text: 'Producto A',
          )
        ]),
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _SingleCard(
      {super.key, required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      height: 180,
      decoration: BoxDecoration(
          color: Color.fromRGBO(140, 90, 232, 0.6),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: this.color,
            child: Icon(
              this.icon,
              size: 35,
            ),
            radius: 30,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            this.text,
            style: TextStyle(color: Colors.black, fontSize: 18),
          )
        ],
      ),
    );
  }
}
