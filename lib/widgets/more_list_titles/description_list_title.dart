import 'package:flutter/material.dart';

class DescriptionListTitle extends StatelessWidget {
  final String title;
  final String description;

  DescriptionListTitle(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: Icon(Icons.edit),
      ),
    );
  }
}
