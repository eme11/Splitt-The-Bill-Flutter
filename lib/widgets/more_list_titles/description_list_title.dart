import 'package:flutter/material.dart';
import '../../pop_up_widows/account_inforamtion_edit.dart';

class DescriptionListTitle extends StatelessWidget {
  final String title;
  final String description;
  final Function openWindow;
  final AccountInformationEditWindow popUp;
  final bool isEditable;

  DescriptionListTitle(this.title, this.description, {this.isEditable = true, this.openWindow, this.popUp});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: isEditable == false ? Text('') :  IconButton(icon:Icon(Icons.edit), onPressed: (){openWindow(popUp);},),
      ),
    );
  }
}
