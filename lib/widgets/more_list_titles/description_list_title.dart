import 'package:flutter/material.dart';

class DescriptionListTitle extends StatelessWidget {
  final String title;
  final String description;
  final bool isEditable;

  DescriptionListTitle(this.title, this.description, {this.isEditable = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: isEditable == false ? Text('') :  Icon(Icons.edit),
      ),
    );
  }
}
