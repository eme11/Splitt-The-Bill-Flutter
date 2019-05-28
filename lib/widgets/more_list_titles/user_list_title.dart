import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped_models/main_model.dart';

class UserListTitle extends StatefulWidget {
  final Function openNewPage;
  final Widget page;

  UserListTitle(this.openNewPage, this.page);

  @override
  State<StatefulWidget> createState() {
    return _UserListTitleState();
  }
}

class _UserListTitleState extends State<UserListTitle> {
  String _getInitials(String firstName, String lastName) {
    return firstName[0].toUpperCase() + lastName[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(_getInitials(model.currentUser.firstName, model.currentUser.lastName)),
          ),
          title: Text(model.currentUser.firstName + ' ' + model.currentUser.lastName),
          subtitle: Text('Account Information'),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              widget.openNewPage(context, widget.page);
            },
          ),
        ),
      );
    });
  }
}
