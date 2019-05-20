import 'package:flutter/material.dart';

class DescriptionListTitle extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  DescriptionListTitle(this.title, this.description, this.icon);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: Icon(Icons.edit),
      ),
    );
  }
}
