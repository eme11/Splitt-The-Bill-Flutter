import 'package:flutter/material.dart';

class TitleListTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  TitleListTitle(this.title, this.icon);

  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title),
      ),
    );
  }
}
