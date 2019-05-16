import 'package:flutter/material.dart';

class SimpleListTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  // later add function parameter

  SimpleListTitle(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
